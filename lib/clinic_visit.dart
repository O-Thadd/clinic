import 'dart:convert';

import 'package:clinic/clinic_visit.dart';

class ClinicVisit {
  num timestamp;
  String bP;
  double? temp;
  int? pulseRate;
  int? oxygenSat;
  double? weight;
  String? historyOfComplaints;
  String? medicalHistory;
  String? examinationFindings;
  String diagnosis;
  String treatment;

  ClinicVisit(
      {required this.timestamp,
      required this.bP,
      this.temp,
      this.pulseRate,
      this.oxygenSat,
      this.weight,
      this.historyOfComplaints,
      this.medicalHistory,
      this.examinationFindings,
      required this.diagnosis,
      required this.treatment});

  ClinicVisit.userGenerated(
      {required this.bP,
      this.temp,
      this.pulseRate,
      this.oxygenSat,
      this.weight,
      this.historyOfComplaints,
      this.medicalHistory,
      this.examinationFindings,
      required this.diagnosis,
      required this.treatment})
      : timestamp = DateTime.timestamp().millisecondsSinceEpoch;

  factory ClinicVisit.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'timestamp': int timestamp,
        'bP': String bp,
        'temp': double? temp,
        'pulseRate': int? pulseRate,
        'oxygenSat': int? oxygenSat,
        'weight': double? weight,
        'historyOfComplaints': String? hpc,
        'medicalHistory': String? medicalHistory,
        'examinationFindings': String? examination,
        'diagnosis': String diagnosis,
        'treatment': String treatment
      } =>
        ClinicVisit(
            timestamp: timestamp,
            bP: bp,
            temp: temp,
            pulseRate: pulseRate,
            oxygenSat: oxygenSat,
            weight: weight,
            historyOfComplaints: hpc,
            medicalHistory: medicalHistory,
            examinationFindings: examination,
            diagnosis: diagnosis,
            treatment: treatment),
      Map<String, dynamic>() => throw UnimplementedError(),
    };
  }

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'bP': bP,
        'temp': temp,
        'pulseRate': pulseRate,
        'oxygenSat': oxygenSat,
        'weight': weight,
        'historyOfComplaints': historyOfComplaints,
        'medicalHistory': medicalHistory,
        'examinationFindings': examinationFindings,
        'diagnosis': diagnosis,
        'treatment': treatment
      };
}
