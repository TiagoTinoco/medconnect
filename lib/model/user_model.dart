import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:medconnect/model/reminder_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String cardNumber;
  final bool isDoctor;
  final List<ReminderModel> reminders;

  UserModel({
    this.uid = '',
    this.cardNumber = '',
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.isDoctor,
    required this.reminders,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'cardNumber': _generateRandomCardNumber(),
      'isDoctor': isDoctor,
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      cardNumber: data['cardNumber'] ?? '',
      isDoctor: data['isDoctor'] ?? '',
      reminders: (data['reminders'] as List<dynamic>? ?? []).map((reminder) {
        return ReminderModel.fromMap(reminder as Map<String, dynamic>);
      }).toList(),
    );
  }

  String _generateRandomCardNumber() {
    final random = Random();

    String rawNumber = [
      random.nextInt(10000).toString().padLeft(4, '0'),
      random.nextInt(100000).toString().padLeft(5, '0'),
      random.nextInt(100).toString().padLeft(2, '0'),
      random.nextInt(10).toString().padLeft(1, '0'),
    ].join();

    MaskedTextController maskController = MaskedTextController(mask: '0000-00000/00-0');

    maskController.text = rawNumber;
    return maskController.text;
  }
}
