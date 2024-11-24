import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialtyModel {
  final String uid;
  final String name;

  SpecialtyModel({
    required this.uid,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory SpecialtyModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return SpecialtyModel(
      uid: doc.id,
      name: doc.data()?['name'] ?? '',
    );
  }
}
