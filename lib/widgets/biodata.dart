import 'package:clinic/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BioData extends StatelessWidget {
  const BioData({
    super.key,
    required this.patient,
    required this.ageController,
    required this.heightController,
    required this.inEditMode,
    required this.getMatchingPatientNames,
    required this.updateSelectedPatientName,
    required this.getMatchingPatientSexes,
    required this.getMatchingPatientMaritalStatus,
    required this.updateSelectedPatientSex,
    required this.updateSelectedPatientMaritalStatus,
    required this.updateSelectedPatientNationality,
    required this.getMatchingPatientNationalities,
    required this.selectPatient,
  });

  final Patient patient;
  final bool inEditMode;
  final Iterable<String> Function(String) getMatchingPatientNames;
  final Iterable<String> Function(String) getMatchingPatientSexes;
  final Iterable<String> Function(String) getMatchingPatientMaritalStatus;
  final Iterable<String> Function(String) getMatchingPatientNationalities;
  final void Function({String? id, String? name}) selectPatient;

  final void Function(String) updateSelectedPatientName;
  final void Function(String) updateSelectedPatientSex;
  final void Function(String) updateSelectedPatientMaritalStatus;
  final void Function(String) updateSelectedPatientNationality;
  final TextEditingController ageController;
  final TextEditingController heightController;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return RawAutocomplete<String>(
              optionsBuilder: (tev) {
                return getMatchingPatientNames(tev.text);
              },
              initialValue: TextEditingValue(text: patient.name),
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        // height: 200,
                        width: 500,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            if (index >= options.length) {
                              return null;
                            }
                            var option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                                selectPatient(name:option);
                              },
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              fieldViewBuilder: (context, controller, focusNode, function) {
                return SizedBox(
                  width:
                      constraints.maxWidth < 500 ? constraints.maxWidth : 500,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    enabled: inEditMode,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: textTheme.labelMedium,
                    ),
                    onChanged: (String name) {
                      updateSelectedPatientName(name);
                    },
                  ),
                );
              },
              onSelected: (String name) {
                updateSelectedPatientName(name);
              },
            );
          },
        ),
        SizedBox(
          width: 400,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ageController,
                  enabled: inEditMode,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: "Age",
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return RawAutocomplete<String>(
                      optionsBuilder: (tev) {
                        return getMatchingPatientSexes(tev.text);
                      },
                      initialValue: TextEditingValue(text: patient.sex),
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: constraints.maxWidth - 16,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    if (index >= options.length) {
                                      return null;
                                    }
                                    var option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: Text(
                                        option,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, function) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: TextField(
                            controller: controller,
                            focusNode: focusNode,
                            enabled: inEditMode,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              labelText: "Sex",
                              labelStyle: textTheme.labelMedium,
                            ),
                            onChanged: (String sex) {
                              updateSelectedPatientSex(sex);
                            },
                          ),
                        );
                      },
                      onSelected: (String sex) {
                        updateSelectedPatientSex(sex);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  controller: heightController,
                  enabled: inEditMode,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: "Height",
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return RawAutocomplete<String>(
                      optionsBuilder: (tev) {
                        return getMatchingPatientMaritalStatus(tev.text);
                      },
                      initialValue:
                          TextEditingValue(text: patient.maritalStatus ?? ""),
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: constraints.maxWidth - 16,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    if (index >= options.length) {
                                      return null;
                                    }
                                    var option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: Text(
                                        option,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, function) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: TextField(
                            controller: controller,
                            focusNode: focusNode,
                            enabled: inEditMode,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              labelText: "Marital Status",
                              labelStyle: textTheme.labelMedium,
                            ),
                            onChanged: (String status) {
                              updateSelectedPatientMaritalStatus(status);
                            },
                          ),
                        );
                      },
                      onSelected: (String status) {
                        updateSelectedPatientMaritalStatus(status);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return RawAutocomplete<String>(
                      optionsBuilder: (tev) {
                        return getMatchingPatientNationalities(tev.text);
                      },
                      initialValue: TextEditingValue(text: patient.nationality),
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: constraints.maxWidth - 10,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    if (index >= options.length) {
                                      return null;
                                    }
                                    var option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: Text(
                                        option,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, function) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: TextField(
                            controller: controller,
                            focusNode: focusNode,
                            enabled: inEditMode,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              labelText: "Nationality",
                              labelStyle: textTheme.labelMedium,
                            ),
                            onChanged: (String nationality) {
                              updateSelectedPatientNationality(nationality);
                            },
                          ),
                        );
                      },
                      onSelected: (String nationality) {
                        updateSelectedPatientNationality(nationality);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
