import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/controller/auth_controller.dart';
import 'package:medconnect/model/specialty_model.dart';

class SpecialtyController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SpecialtyModel>?> getSpecialties() async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await _firestore.collection('specialties').get();

      return response.docs.map((doc) {
        return SpecialtyModel.fromDocument(doc);
      }).toList();
    } catch (error) {
      throw GenericException(message: 'Erro ao obter as especialidades médicas.');
    }
  }
}
