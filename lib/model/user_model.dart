class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final bool isDoctor;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.isDoctor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isDoctor': isDoctor,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      isDoctor: map['isDoctor'] as bool,
    );
  }
}
