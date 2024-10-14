import 'package:clinic/clinic_visit.dart';
import 'package:clinic/patient.dart';
import 'package:clinic/widgets/biodata.dart';
import 'package:clinic/widgets/clinicVisit.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({
    super.key,
    required this.patient,
    required this.updatePatient,
    required this.networkBusy,
    required this.getPatientNames,
    required this.getPatientSexes,
    required this.getPatientMaritalStatus,
    required this.getPatientNationalities,
    required this.selectPatient,
    required this.deletePatient,
    required this.deleteVisit,
  });

  final Patient? patient;
  final bool networkBusy;
  final void Function(Patient) updatePatient;
  final Iterable<String> Function(String) getPatientNames;
  final Iterable<String> Function(String) getPatientSexes;
  final Iterable<String> Function(String) getPatientMaritalStatus;
  final Iterable<String> Function(String) getPatientNationalities;
  final void Function({String? id, String? name}) selectPatient;
  final void Function() deletePatient;
  final void Function(int) deleteVisit;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var inEditMode = false;
  var deleteMenuShowing = false;
  int selectedVisitIndex = 0;
  late final void Function(int) selectVisit;
  late final void Function() createVisit;
  late String selectedPatientName;
  late String selectedPatientSex;
  late String? selectedPatientMaritalStatus;
  late String selectedPatientNationality;

  final ageController = TextEditingController();
  final heightController = TextEditingController();

  final bpController = TextEditingController();
  final tempController = TextEditingController();
  final pulseRateController = TextEditingController();
  final oxygenSatController = TextEditingController();
  final weightController = TextEditingController();
  final hpcController = TextEditingController();
  final diagnosisController = TextEditingController();
  final treatmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectVisit = (int newIndex) {
      setState(() {
        selectedVisitIndex = newIndex;
      });
    };

    createVisit = () {
      var updatedPatient = widget.patient;
      updatedPatient?.clinicVisits
          .add(ClinicVisit.userGenerated(bP: "", diagnosis: "", treatment: ""));
      widget.updatePatient(updatedPatient!);
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widget.patient == null) {
      return const Center(child: Text("select a patient to view details\n\nthis is definitely new...hehe"));
    }

    var visit = widget.patient!.clinicVisits[selectedVisitIndex];

    selectedPatientName = widget.patient!.name;
    selectedPatientSex = widget.patient!.sex;
    selectedPatientMaritalStatus = widget.patient!.maritalStatus;
    selectedPatientNationality = widget.patient!.nationality;
    ageController.text = widget.patient!.age?.toString() ?? "";
    heightController.text = widget.patient!.height?.toString() ?? "";

    bpController.text = visit.bP;
    tempController.text = visit.temp?.toString() ?? "";
    pulseRateController.text = visit.pulseRate?.toString() ?? "";
    oxygenSatController.text = visit.oxygenSat?.toString() ?? "";
    weightController.text = visit.weight?.toString() ?? "";
    hpcController.text = visit.historyOfComplaints ?? "";
    diagnosisController.text = visit.diagnosis;
    treatmentController.text = visit.treatment;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BioData(
              patient: widget.patient!,
              inEditMode: inEditMode,
              ageController: ageController,
              heightController: heightController,
              getMatchingPatientNames: widget.getPatientNames,
              updateSelectedPatientName: (String name) {
                selectedPatientName = name;
              },
              getMatchingPatientSexes: widget.getPatientSexes,
              getMatchingPatientMaritalStatus: widget.getPatientMaritalStatus,
              updateSelectedPatientSex: (String sex) {
                selectedPatientSex = sex;
              },
              updateSelectedPatientMaritalStatus: (String maritalStatus) {
                selectedPatientMaritalStatus = maritalStatus;
              },
              updateSelectedPatientNationality: (String nationality) {
                selectedPatientNationality = nationality;
              },
              getMatchingPatientNationalities: widget.getPatientNationalities,
              selectPatient: widget.selectPatient,
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 0.5),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: VisitsListWidget(
                visits: widget.patient!.clinicVisits,
                selectedIndex: selectedVisitIndex,
                select: selectVisit,
                addVisit: createVisit,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ClinicVisitWidget(
                inEditMode: inEditMode,
                visit: visit,
                bpController: bpController,
                tempController: tempController,
                pulseRateController: pulseRateController,
                oxygenSatController: oxygenSatController,
                weightController: weightController,
                hpcController: hpcController,
                diagnosisController: diagnosisController,
                treatmentController: treatmentController,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    deleteMenuShowing = !deleteMenuShowing;
                  });
                },
                icon: const Icon(Icons.delete),
              ),
              const Expanded(child: SizedBox()),
              Visibility(
                visible: widget.networkBusy,
                child: const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    strokeWidth: 2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: inEditMode
                    ? null
                    : () {
                        setState(() {
                          inEditMode = true;
                        });
                      },
                child: const Text("edit"),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  var updatedPatient = widget.patient;
                  updateUpdatedPatient(updatedPatient);
                  setState(() {
                    inEditMode = false;
                  });
                  widget.updatePatient(updatedPatient!);
                },
                child: const Text("Save"),
                // label: const ,
              ),
            ],
          ),
        ),
        Visibility(
          visible: deleteMenuShowing,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 40),
              child: Material(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('delete patient called at detail in gesture detector');
                          setState(() {
                            deleteMenuShowing = false;
                          });
                          print('delete patient called at detail in gesture detector. menu hidden. now about calling delete patient ');
                          widget.deletePatient();
                          print('delete patient called at detail in gesture detector. delete patient called');
                        },
                        child: Text('Delete Patient'),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          deleteClinicVisit();
                        },
                        child: Text('Delete only this clinic visit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void deleteClinicVisit() {
    setState(() {
      deleteMenuShowing = false;
    });

    if(widget.patient!.clinicVisits.length == 1){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Patient must have at least one visit")));
      return;
    }

    var indexToDelete = selectedVisitIndex;
    if(selectedVisitIndex == widget.patient!.clinicVisits.length -1){
      selectedVisitIndex = selectedVisitIndex - 1;
    }
    widget.deleteVisit(indexToDelete);
  }

  void updateUpdatedPatient(Patient? updatedPatient) {
    updatedPatient?.name = selectedPatientName;
    updatedPatient?.age = int.tryParse(ageController.text);
    updatedPatient?.sex = selectedPatientSex;
    updatedPatient?.height = double.tryParse(heightController.text);
    updatedPatient?.maritalStatus = selectedPatientMaritalStatus;
    updatedPatient?.nationality = selectedPatientNationality;

    var clinicVisit = updatedPatient?.clinicVisits[selectedVisitIndex];
    clinicVisit?.bP = bpController.text;
    clinicVisit?.temp = double.tryParse(tempController.text);
    clinicVisit?.pulseRate = int.tryParse(pulseRateController.text);
    clinicVisit?.oxygenSat = int.tryParse(oxygenSatController.text);
    clinicVisit?.weight = double.tryParse(weightController.text);
    clinicVisit?.historyOfComplaints = hpcController.text;
    clinicVisit?.diagnosis = diagnosisController.text;
    clinicVisit?.treatment = treatmentController.text;

    updatedPatient?.clinicVisits.removeAt(selectedVisitIndex);
    updatedPatient?.clinicVisits.insert(selectedVisitIndex, clinicVisit!);
  }
}
