import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient.dart';
import '../models/result.dart';

class PatientService {
  final CollectionReference _patients =
      FirebaseFirestore.instance.collection('Patients');

  Patient? _currentPatient;

  void setCurrentPatient(Patient? patient) {
    _currentPatient = patient;
  }

  Future<Result<void>> createPatient(Patient patient) async {
    try {
      await _patients.doc(patient.uid).set(patient.toMap());
      setCurrentPatient(patient);
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<Patient>> getPatient(String uid) async {
    try {
      DocumentSnapshot doc = await _patients.doc(uid).get();
      _currentPatient = Patient.fromMap(doc.data() as Map<String, dynamic>);
      return Result.success(_currentPatient!);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> updatePatient(String uid, Patient patient) async {
    try {
      await _patients.doc(uid).update(patient.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> deletePatient(String uid) async {
    try {
      await _patients.doc(uid).delete();
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
