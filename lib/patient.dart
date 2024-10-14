import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'clinic_visit.dart';

class Patient {
  String id;
  String name;
  int? age;
  String sex;
  String? maritalStatus;
  double? height;
  String nationality;
  List<ClinicVisit> clinicVisits;

  Patient({
    required this.id,
    required this.name,
    this.age,
    required this.sex,
    this.maritalStatus,
    this.height,
    required this.nationality,
    required this.clinicVisits
  });

  Patient.userGenerated({
    required this.name,
    this.age,
    required this.sex,
    this.maritalStatus,
    this.height,
    required this.nationality,
    required this.clinicVisits
  }) :
        id = const Uuid().v8();

  factory Patient.fromJson(Map<String, dynamic> json){
    if (json case {
    'id': String id,
    'name': String name,
    'age': int? age,
    'sex': String? sex,
    'maritalStatus': String? maritalStatus,
    'height': double? height,
    'nationality': String? nationality,
    'clinicVisits': List<dynamic>? clinicVisits
    }) {
      var visits = clinicVisits?.map((e) =>
          ClinicVisit.fromMap(e as Map<String, dynamic>)).toList();
      return Patient(id: id, name: name, age: age, sex: sex ?? "", maritalStatus: maritalStatus, height: height, nationality: nationality ?? "", clinicVisits: visits ?? List.empty());
    }
    else {
      throw UnimplementedError();
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'age': age,
        'sex': sex,
        'maritalStatus': maritalStatus,
        'height': height,
        'nationality': nationality,
        'clinicVisits': clinicVisits.map((e) => e.toJson()).toList()
      };
}