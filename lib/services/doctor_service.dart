import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor.dart';
import '../models/result.dart'; // Ensure the path is correct

class DoctorService {
  final CollectionReference _doctors =
      FirebaseFirestore.instance.collection('Doctors');

  Doctor? _currentDoctor;

  Doctor? getCurrentDoctor() => _currentDoctor;

  Future<Result<void>> createDoctor(Doctor doctor) async {
    try {
      await _doctors.doc(doctor.uid).set(doctor.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<Doctor>> getDoctor(String uid) async {
    try {
      DocumentSnapshot doc = await _doctors.doc(uid).get();
      _currentDoctor = Doctor.fromMap(doc.data() as Map<String, dynamic>);
      return Result.success(_currentDoctor!);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> updateDoctor(String uid, Doctor doctor) async {
    try {
      await _doctors.doc(uid).update(doctor.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> deleteDoctor(String uid) async {
    try {
      await _doctors.doc(uid).delete();
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<List<Doctor>>> searchDoctorBySpeciality(
      String speciality) async {
    try {
      QuerySnapshot querySnapshot =
          await _doctors.where('specialties', arrayContains: speciality).get();
      List<Doctor> doctors = querySnapshot.docs
          .map((doc) => Doctor.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Result.success(doctors);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
