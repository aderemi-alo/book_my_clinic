class Patient {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final int age;
  final String sex;
  final List appointmentIDs;

  Patient({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.sex,
    required this.appointmentIDs,
  });

  //Convert Firestore map to Patient
  Patient.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        email = map['email'],
        phoneNumber = map['phoneNumber'],
        age = map['age'],
        sex = map['sex'],
        appointmentIDs = map['appointmentIDs'];

  // Converts Patient object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'age': age,
      'sex': sex,
      'appointmentIDs': appointmentIDs
    };
  }
}
