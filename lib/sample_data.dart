import 'package:clinic/clinic_visit.dart';
import 'package:clinic/patient.dart';

final visit1 = ClinicVisit.userGenerated(
    bP: "120/80",
    temp: 36,
    pulseRate: 20,
    oxygenSat: 98,
    weight: 80,
    historyOfComplaints: "headache, weakness",
    medicalHistory: null,
    examinationFindings: null,
    diagnosis: "Malaria",
    treatment: "Tab ACT 80/480 bd X 3/7 \n Tab PCM 1g tds X 5/7");

final visit2 = ClinicVisit.userGenerated(
    bP: "130/90",
    temp: 36,
    pulseRate: 22,
    oxygenSat: 99,
    weight: 70,
    historyOfComplaints: "diarrhoea, weakness",
    medicalHistory: null,
    examinationFindings: "dehydrated",
    diagnosis: "Enteritis",
    treatment:
        "Tab Metronidazole 400mg tds X 5/7 \n Tab PCM 1g tds X 5/7 \n ORS solution 1L daily X 2/7");

final visit3 = ClinicVisit.userGenerated(
    bP: "110/90",
    temp: 37,
    pulseRate: 20,
    oxygenSat: 98,
    weight: 78,
    historyOfComplaints: "waist pain, upper back pain\n3 days duration, no fever, no weakness",
    medicalHistory: null,
    examinationFindings: null,
    diagnosis: "MSK pain",
    treatment: "Tab Arthrotec 1 tds X 3/7 \n Tab Methocarbomol 1 tds X 3/7");

final visit4 = ClinicVisit.userGenerated(
    bP: "120/80",
    temp: 36,
    pulseRate: 20,
    oxygenSat: 98,
    weight: 80,
    historyOfComplaints: "headache, weakness",
    medicalHistory: null,
    examinationFindings: null,
    diagnosis: "Malaria",
    treatment: "Tab ACT 80/480 bd X 3/7 \n Tab PCM 1g tds X 5/7");

final patient1 = Patient.userGenerated(
  name: "Jim",
  age: 47,
  sex: "Male",
  maritalStatus: "Married",
  height: 1.62,
  nationality: "Expatriate",
  clinicVisits: [visit1],
);

final patient2 = Patient.userGenerated(
  name: "Timmy",
  age: 50,
  sex: "Male",
  maritalStatus: "Single",
  height: 1.70,
  nationality: "Expatriate",
  clinicVisits: [visit2, visit3],
);

final patient3 = Patient.userGenerated(
  name: "Jon",
  age: 37,
  sex: "Male",
  maritalStatus: "Married",
  height: 1.62,
  nationality: "Nigerian",
  clinicVisits: [visit3],
);

final patient4 = Patient.userGenerated(
  name: "Hassan",
  age: 47,
  sex: "Male",
  maritalStatus: "Married",
  height: 1.49,
  nationality: "Nigerian",
  clinicVisits: [visit4, visit3],
);

final patient5 = Patient.userGenerated(
  name: "Haj",
  age: 27,
  sex: "Male",
  maritalStatus: "Single",
  height: 1.45,
  nationality: "Expatriate",
  clinicVisits: [visit2],
);

final patients = [patient1, patient2, patient3, patient4, patient5];