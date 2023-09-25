import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String status;
  final DateTime dateTime;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.status,
    required this.dateTime,
  });

  static Appointment fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      patientId: map['patientId'],
      doctorId: map['doctorId'],
      status: map['status'],
      dateTime: (map['dateTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'status': status,
      'dateTime': dateTime,
    };
  }
}
