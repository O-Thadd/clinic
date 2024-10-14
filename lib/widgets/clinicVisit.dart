import 'package:clinic/clinic_visit.dart';
import 'package:clinic/utils.dart';
import 'package:clinic/widgets/clinicVisit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClinicVisitWidget extends StatelessWidget {
  const ClinicVisitWidget({
    super.key,
    required this.visit,
    required this.bpController,
    required this.tempController,
    required this.pulseRateController,
    required this.oxygenSatController,
    required this.weightController,
    required this.hpcController,
    required this.diagnosisController,
    required this.treatmentController,
    required this.inEditMode,
  });

  final ClinicVisit visit;
  final bool inEditMode;

  final TextEditingController bpController;
  final TextEditingController tempController;
  final TextEditingController pulseRateController;
  final TextEditingController oxygenSatController;
  final TextEditingController weightController;
  final TextEditingController hpcController;
  final TextEditingController diagnosisController;
  final TextEditingController treatmentController;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: bpController,
                enabled: inEditMode,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Blood Pressure",
                    labelStyle: textTheme.labelMedium),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: tempController,
                enabled: inEditMode,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Temperature",
                    labelStyle: textTheme.labelMedium),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: pulseRateController,
                enabled: inEditMode,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Pulse Rate",
                    labelStyle: textTheme.labelMedium),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: oxygenSatController,
                enabled: inEditMode,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Oxygen Saturation",
                    labelStyle: textTheme.labelMedium),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: weightController,
                enabled: inEditMode,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Weight",
                    labelStyle: textTheme.labelMedium),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: colorTheme.surface,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Complaints, History and Examination findings:",
                  style: textTheme.labelSmall,
                ),
                Expanded(
                  child: TextField(
                    controller: hpcController,
                    enabled: inEditMode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: diagnosisController,
          enabled: inEditMode,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Assessment / Diagnosis",
              labelStyle: textTheme.labelMedium),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: treatmentController,
          enabled: inEditMode,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Treatment",
              labelStyle: textTheme.labelMedium),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ],
    );
  }
}

class VisitsListWidget extends StatelessWidget {
  const VisitsListWidget({
    super.key,
    required this.visits,
    required this.selectedIndex,
    required this.select,
    required this.addVisit,
  });

  final List<ClinicVisit> visits;
  final int selectedIndex;
  final void Function(int) select;
  final void Function() addVisit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              primary: true,
              scrollDirection: Axis.horizontal,
              itemCount: visits.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        select(index);
                      },
                      child: Container(
                        // alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: selectedIndex == index
                              ? Theme.of(context).colorScheme.surface
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "visit ${index + 1}",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              formattedDate(visits[index].timestamp),
                              // visits[index].timestamp.toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                );
              },
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: addVisit,
        )
      ],
    );
  }
}
