import 'package:clinic/patient.dart';
import 'package:clinic/utils.dart';
import 'package:clinic/widgets/clinicVisit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SideBar extends StatelessWidget {
  SideBar(
      {super.key,
      required this.patients,
      required this.selectedPatientId,
      required this.createPatient,
      required this.syncPatients,
      required this.networkBusy,
      required this.selectPatient});

  final List<Patient> patients;
  final String? selectedPatientId;
  final bool networkBusy;
  final void Function({String? id, String? name}) selectPatient;
  final Function() createPatient;
  final Function() syncPatients;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 56),
          child: patients.isNotEmpty
              ? Scrollbar(
            thumbVisibility: true,
            controller: scrollController,
                  child: ListView.builder(
                    // primary: true,
                    controller: scrollController,
                    itemCount: patients.length,
                    itemBuilder: (BuildContext context, int index) {
                      var thisPatient = patients[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                selectPatient(id: thisPatient.id);
                              },
                              child: SideBarPatient(
                                patient: thisPatient,
                                selected: thisPatient.id == selectedPatientId,
                              )),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      );
                    },
                  ),
                )
              : const Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("No patients. Try syncing"),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Visibility(
                      visible: !networkBusy,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: syncPatients,
                          icon: const Icon(Icons.cloud_sync),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: networkBusy,
                      child: const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                FilledButton(
                  onPressed: createPatient,
                  child: const Text(
                    "New Patient",
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SideBarPatient extends StatelessWidget {
  const SideBarPatient(
      {super.key, required this.patient, required this.selected});

  final Patient patient;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var color = selected ? colorScheme.background : colorScheme.surface;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      color: color,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(patient.name, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              '${patient.sex}, ${patient.age}, ${patient.clinicVisits.length} visit(s), ${formattedDate(patient.clinicVisits.last.timestamp)}',
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
      ),
    );
  }
}
