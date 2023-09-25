import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_my_clinic/app/app.locator.dart';
import 'authentication_service.dart';
import '../models/appointment.dart';
import '../models/result.dart';
import 'package:uuid/uuid.dart';

class AppointmentService {
  final CollectionReference _appointments =
      FirebaseFirestore.instance.collection('Appointments');

  final _authenticationService = locator<AuthenticationService>();

  // ignore: prefer_const_constructors
  var uuid = Uuid();

  Future<Result<void>> createAppointment(
      String doctorId, DateTime dateTime) async {
    try {
      String id = uuid.v4();
      Appointment appointment = Appointment(
        id: id,
        patientId: _authenticationService.getCurrentUser()!.uid,
        doctorId: doctorId,
        status: "pending",
        dateTime: dateTime,
      );
      await _appointments.doc(id).set(appointment.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> updateAppointment(
      {required String appointmentId, required String status}) async {
    try {
      await _appointments
          .doc(appointmentId)
          .update({'status': status.toLowerCase()});
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> rescheduleAppointment(
      {required String appointmentId, required DateTime newDateTime}) async {
    try {
      await _appointments.doc(appointmentId).update({'dateTime': newDateTime});
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<List<Appointment>>> fetchAppointments(
      {String? doctorID, String? patientID}) async {
    QuerySnapshot querySnapshot;
    try {
      if (patientID != null) {
        querySnapshot =
            await _appointments.where('patientId', isEqualTo: patientID).get();
      } else {
        querySnapshot =
            await _appointments.where('doctorId', isEqualTo: doctorID).get();
      }
      List<Appointment> appointments = querySnapshot.docs
          .map((doc) => Appointment.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Result.success(appointments);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  // Future<Result<Appointment>> getAppointment() {}
}
