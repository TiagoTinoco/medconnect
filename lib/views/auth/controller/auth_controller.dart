import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/model/user_model.dart';

class AuthException implements Exception {
  String message;

  AuthException({required this.message});
}

class AuthController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user;
  bool isSignUp = false;
  bool isLoading = true;

  AuthController() {
    _authCheck();
  }

  _authCheck() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _firebaseAuth.currentUser;

    Future.wait(
      [Future<void>.delayed(const Duration(milliseconds: 2000))],
    ).then((_) async {
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _getUser();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw AuthException(message: 'O usuário não foi encontrado.');
      } else if (error.code == 'invalid-credential') {
        throw AuthException(message: 'E-mail ou senha incorreto. Tente novamente.');
      } else if (error.code == 'too-many-requests') {
        throw AuthException(message: 'Muitas tentativas, aguarde e tente novamente.');
      }
    } catch (error) {
      throw AuthException(message: 'Houve um erro inesperado');
    }
  }

  Future<void> signUp(UserModel user, String password) async {
    isSignUp = true;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      await _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).set(user.toMap());

      await _getUser();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        throw AuthException(message: 'A senha é muito fraca.');
      } else if (error.code == 'email-already-in-use') {
        throw AuthException(message: 'Esse email ja está cadastrado.');
      }
    } catch (error) {
      throw AuthException(message: 'Não foi possivel cadastrar. Tente novamente.');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _getUser();
    } catch (error) {
      throw AuthException(message: 'Houve um erro inesperado.');
    }
  }
}
