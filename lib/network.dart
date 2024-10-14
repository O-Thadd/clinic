import 'dart:convert';

import 'package:clinic/patient.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://clinic-dot-coastal-haven-309701.ew.r.appspot.com/";
// "http://localhost:8080/"
// "https://clinic-dot-coastal-haven-309701.ew.r.appspot.com/"

Future<bool> uploadPatients(List<Patient> patients) async {
  try {
    print('starting send');
    String patientsString = jsonEncode(patients);
    print('sending: $patientsString');
    await http.post(
      Uri.parse('${baseUrl}patients'),
      body: <String, String>{'patients': patientsString},
    );
    print('sending complete');
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<Patient>?> downloadPatients() async {
  try {
    print('get called');
    print('requesting...');
    var gh = await http.get(Uri.parse("${baseUrl}patients"));
    print('gotten!');
    print('response body is: ${gh.body}');
    var patientsJson = jsonDecode(gh.body) as List;
    var patients = patientsJson.map((e) => Patient.fromJson(e)).toList();
    return patients;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<bool> deletePatient(String patientId) async {
  try {
    print('delete called...');
    print('id: $patientId');
    await http.delete(
      Uri.parse("${baseUrl}patients"),
      body: <String, String>{'patientId': patientId},
    );
    print('deleted!');
    return true;
  } catch (e) {
    return false;
  }
}
