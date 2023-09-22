class Doctor {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String sex;
  final String hospital;
  final String hospitalAddress;
  final List<String> specialties;

  Doctor({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.sex,
    required this.hospital,
    required this.hospitalAddress,
    required this.specialties,
  });

  // Converts Firestore Map to Doctor object
  static Doctor fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      sex: map['sex'],
      hospital: map['hospital'],
      hospitalAddress: map['hospitalAddress'],
      specialties: List<String>.from(map['specialties']),
    );
  }

  // Converts Doctor object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'sex': sex,
      'hospital': hospital,
      'hospitalAddress': hospitalAddress,
      'specialties': specialties,
    };
  }
}
