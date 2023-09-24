class Doctor {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;
  final String hospital;
  final String hospitalAddress;
  final List<String> specialties;
  final List appointmentIDs;

  Doctor({
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.hospital,
    required this.hospitalAddress,
    required this.specialties,
    required this.appointmentIDs,
  });

  // Converts Firestore Map to Doctor object
  static Doctor fromMap(Map<String, dynamic> map) {
    return Doctor(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      hospital: map['hospital'],
      hospitalAddress: map['hospitalAddress'],
      specialties: List<String>.from(map['specialties']),
      appointmentIDs: [],
    );
  }

  // Converts Doctor object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'hospital': hospital,
      'hospitalAddress': hospitalAddress,
      'specialties': specialties,
    };
  }
}
