class Patient {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final List appointmentIDs;

  Patient({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.appointmentIDs,
  });

  //Convert Firestore map to Patient
  Patient.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        email = map['email'],
        phoneNumber = map['phoneNumber'],
        appointmentIDs = map['appointmentIDs'];

  // Converts Patient object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'appointmentIDs': appointmentIDs
    };
  }
}
