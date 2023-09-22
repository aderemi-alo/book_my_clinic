import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor.dart';
import '../models/result.dart'; // Ensure the path is correct

class DoctorService {
  final CollectionReference _doctors =
      FirebaseFirestore.instance.collection('doctors');

  Doctor? _currentDoctor;

  Doctor? getCurrentDoctor() => _currentDoctor;

  Future<Result<void>> createDoctor(Doctor doctor) async {
    try {
      await _doctors.add(doctor.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<Doctor>> getDoctor(String id) async {
    try {
      DocumentSnapshot doc = await _doctors.doc(id).get();
      _currentDoctor = Doctor.fromMap(doc.data() as Map<String, dynamic>);
      return Result.success(_currentDoctor!);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> updateDoctor(String id, Doctor doctor) async {
    try {
      await _doctors.doc(id).update(doctor.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> deleteDoctor(String id) async {
    try {
      await _doctors.doc(id).delete();
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
