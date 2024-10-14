import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:clinic/clinic_visit.dart';
import 'package:clinic/network.dart' as network;
import 'package:clinic/patient.dart';
import 'package:clinic/widgets/detail.dart';
import 'package:clinic/widgets/sideBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.patients});

  final List<Patient> patients;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Patient> localPatients;
  late final void Function() createPatient;
  late final void Function(Patient) savePatient;
  late final void Function({String? id, String? name}) selectPatient;
  late final void Function() getPatients;
  late final void Function() deletePatient;
  late final void Function(int) deleteVisit;
  late final Iterable<String> Function(String) getPatientNames;
  late final Iterable<String> Function(String) getPatientSexes;
  late final Iterable<String> Function(String) getPatientMaritalStatus;
  late final Iterable<String> Function(String) getPatientNationalities;
  String? selectedPatientId;
  var netWorkBusy = false;

  @override
  void initState() {
    super.initState();

    localPatients = widget.patients;

    createPatient = () {
      setState(() {
        var newPatient = Patient.userGenerated(
          name: "new patient",
          sex: "",
          nationality: "",
          clinicVisits: [
            ClinicVisit.userGenerated(
                bP: "",
                temp: null,
                pulseRate: null,
                oxygenSat: null,
                weight: null,
                diagnosis: "",
                treatment: "")
          ],
        );
        localPatients.add(newPatient);
      });
    };

    savePatient = (Patient patient) async {
      setState(() {
        netWorkBusy = true;
        Patient? oldVersion;
        try {
          oldVersion =
              localPatients.firstWhere((element) => element.id == patient.id);
        } catch (e) {}

        var patientIndex = localPatients.length;
        if (oldVersion != null) {
          patientIndex = localPatients.indexOf(oldVersion);
          localPatients.removeAt(patientIndex);
        }
        localPatients.insert(patientIndex, patient);
      });
      var success = await network.uploadPatients(localPatients);
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error occurred. Check network and try again.")));
      }
      setState(() {
        netWorkBusy = false;
      });
    };

    selectPatient = ({String? id, String? name}) {
      if (id != null) {
        if (selectedPatientId == id) {
          return;
        }
        setState(() {
          selectedPatientId = id;
        });
      }

      if (name != null) {
        Patient? selectedPatient;
        try {
          selectedPatient = localPatients
              .firstWhere((element) => element.id == selectedPatientId);
        } catch (e) {}

        if (selectedPatient != null && selectedPatient.name == name) {
          return;
        }

        var patientToBeSelected =
            localPatients.firstWhere((element) => element.name == name);
        setState(() {
          selectedPatientId = patientToBeSelected.id;
        });
      }
    };

    getPatients = () async {
      setState(() {
        netWorkBusy = true;
      });
      var patients = await network.downloadPatients();
      setState(() {
        var retrievedPatients = patients;
        if (retrievedPatients != null) {
          localPatients = retrievedPatients;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Error occurred. Check network and try again.")));
        }
        netWorkBusy = false;
      });
    };

    getPatientNames = (String name) {
      if (name.isEmpty) {
        return List.empty();
      }
      var names = localPatients
          .where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .where((element) => element.name != 'new patient')
          .map((e) => e.name);
      return names;
    };

    getPatientSexes = (String sex) {
      if (sex.isEmpty) {
        return localPatients.map((e) => e.sex).where((element) => element.isNotEmpty).toSet();
      }
      var names = localPatients
          .where((element) =>
              element.sex.toLowerCase().contains(sex.toLowerCase()))
          .map((e) => e.sex)
          .toSet();
      return names;
    };

    getPatientMaritalStatus = (String maritalStatus) {
      if (maritalStatus.isEmpty) {
        return localPatients
            .where((element) => element.maritalStatus != null)
            .map((e) => e.maritalStatus!)
            .toSet();
      }

      var status = localPatients
          .where((element) => element.maritalStatus != null)
          .where((element) => element.maritalStatus!
              .toLowerCase()
              .contains(maritalStatus.toLowerCase()))
          .map((e) => e.maritalStatus!)
          .toSet();
      return status;
    };

    getPatientNationalities = (String nationality) {
      if (nationality.isEmpty) {
        return localPatients
            .where((element) => element.nationality.isNotEmpty)
            .map((e) => e.nationality)
            .toSet();
      }

      var nationalities = localPatients
          .where((element) => element.nationality
              .toLowerCase()
              .contains(nationality.toLowerCase()))
          .map((e) => e.nationality)
          .toSet();
      return nationalities;
    };

    deletePatient = () async {
      setState(() {
        netWorkBusy = true;
      });
      var success = await network.deletePatient(selectedPatientId!);
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error occurred. Check network and try again.")));
      } else {
        setState(() {
          selectedPatientId = null;
        });
        await Future.delayed(const Duration(milliseconds: 300));
        getPatients();
      }
      setState(() {
        netWorkBusy = false;
      });
    };

    deleteVisit = (int visitIndex) {
      setState(() {
        netWorkBusy = true;
      });
      var updatedPatient = localPatients
          .firstWhere((element) => element.id == selectedPatientId);
      updatedPatient.clinicVisits.removeAt(visitIndex);
      savePatient(updatedPatient);
      setState(() {
        netWorkBusy = false;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    Patient? selectedPatient;
    try {
      selectedPatient = localPatients
          .firstWhere((element) => element.id == selectedPatientId);
    } catch (e) {}

    var colorTheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [colorTheme.background, colorTheme.surface],
            stops: const [0.0, 1.0],
          )),
          child: WindowTitleBarBox(
            child: Row(
              children: [
                const SizedBox(width: 16),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/images/wizard_emoji.png'),
                ),
                const SizedBox(width: 8),
                Text(
                  "Clinic",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Expanded(child: MoveWindow()),
                const WindowButtons(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Theme.of(context).colorScheme.surface,
                child: SideBar(
                  patients: localPatients,
                  selectPatient: selectPatient,
                  selectedPatientId: selectedPatientId,
                  createPatient: createPatient,
                  syncPatients: getPatients,
                  networkBusy: netWorkBusy,
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Detail(
                      key: ObjectKey(selectedPatient?.id ?? "null"),
                      patient: selectedPatient,
                      updatePatient: savePatient,
                      networkBusy: netWorkBusy,
                      getPatientNames: getPatientNames,
                      getPatientSexes: getPatientSexes,
                      getPatientMaritalStatus: getPatientMaritalStatus,
                      getPatientNationalities: getPatientNationalities,
                      selectPatient: selectPatient,
                      deletePatient: deletePatient,
                      deleteVisit: deleteVisit,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}
