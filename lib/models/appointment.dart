import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String status;
  final DateTime dateTime;
  final int duration;
  final bool wasPatientPresent;
  final bool wasDoctorPresent;
  // ... potentially other fields

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.status,
    required this.dateTime,
    required this.duration,
    required this.wasPatientPresent,
    required this.wasDoctorPresent,
    // ... potentially other fields
  });

  // Converts Firestore Map to Appointment object
  static Appointment fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      patientId: map['patientId'],
      doctorId: map['doctorId'],
      status: map['status'],
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      duration: map['duration'],
      wasPatientPresent: map['wasPatientPresent'],
      wasDoctorPresent: map['wasDoctorPresent'],
      // ... potentially other fields
    );
  }

  // Converts Appointment object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'status': status,
      'dateTime': dateTime,
      'duration': duration,
      'wasPatientPresent': wasPatientPresent,
      'wasDoctorPresent': wasDoctorPresent,
      // ... potentially other fields
    };
  }
}
