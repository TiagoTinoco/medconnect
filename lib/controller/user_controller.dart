import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:medconnect/controller/auth_controller.dart';
import 'package:medconnect/model/reminder_model.dart';
import 'package:medconnect/model/user_model.dart';

class UserController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser = FirebaseAuth.instance.currentUser;
  late UserModel? _user;

  String get uid => _user!.uid;
  String get name => _user!.name;
  String get email => _user!.email;
  String get phoneNumber => _user!.phoneNumber;
  String get cardNumber => _user!.cardNumber;
  bool get isDoctor => _user!.isDoctor;
  List<ReminderModel> get reminders => _user!.reminders;

  Future<UserModel?> getUser() async {
    try {
      if (currentUser == null) {
        throw GenericException(message: 'Nenhum usuário autenticado.');
      }

      DocumentSnapshot response = await _firestore.collection('users').doc(currentUser!.uid).get();

      if (response.exists) {
        _user = UserModel.fromDocument(response);
        return _user;
      } else {
        throw GenericException(message: 'Nenhum usuário encontrado.');
      }
    } catch (error) {
      throw GenericException(message: 'Erro ao obter usuário.');
    }
  }

  Future<void> deleteUser(AuthCredential credential) async {
    try {
      await currentUser!.reauthenticateWithCredential(credential);

      await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).delete();

      await currentUser!.delete();

      await _firebaseAuth.signOut();
    } catch (error) {
      throw GenericException(message: 'Erro ao deletar o usúario.');
    } finally {
      notifyListeners();
    }
  }
}
