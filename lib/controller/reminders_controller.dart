import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/controller/auth_controller.dart';
import 'package:medconnect/model/reminder_model.dart';

class ReminderController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;

  String _name = "";
  String _hoursTime = "";
  String _dateTime = "";

  set name(String newName) => _name = newName;
  set hoursTime(String newHoursTime) => _hoursTime = newHoursTime;
  set dateTime(String newDateTime) => _dateTime = newDateTime;

  Stream<DocumentSnapshot> getReminders() {
    try {
      return _firestore.collection('users').doc(currentUser!.uid).snapshots();
    } catch (error) {
      throw GenericException(message: 'Erro ao pegar os lembretes.');
    }
  }

  Future<void> saveReminder(List<ReminderModel> oldReminders) async {
    try {
      oldReminders.add(ReminderModel(
        specialtieName: _name,
        dateTime: _dateTime,
        hoursTime: _hoursTime,
      ));

      final List<Map<String, dynamic>> remindersMap = oldReminders.map((reminder) => reminder.toMap()).toList();

      await _firestore.collection('users').doc(currentUser!.uid).update({
        'reminders': remindersMap,
      });

      notifyListeners();
    } catch (erro) {
      throw GenericException(message: 'Erro ao salvar uma consulta na agenda.');
    }
  }
}
