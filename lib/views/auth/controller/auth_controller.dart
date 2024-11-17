import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/model/user_model.dart';

/// Custom throw exception that return a messages
class AuthException implements Exception {
  String message;

  AuthException({required this.message});
}

/// Created a controller class that extends [ChangeNotifier], it is default [provider] class
class AuthController extends ChangeNotifier {
  /// The [FirebaseAuth] this variable controll the [signIn] and [signUp]. In addition it manage the email and password of [user]
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// The [FirebaseFirestore] this variable controll the [data base]. In addition it all manage the collections, it is [CRUD] (get, set, update and delete).
  /// You can get an instance by calling [_firestore]. for example:
  ///
  /// ```dart
  /// _firestore.collection('users').doc('id' OPTIONAL).get();
  /// _firestore.collection('users').doc('id').set({})
  /// _firestore.collection('users').doc('id').update({});
  /// _firestore.collection('users').doc('id').delete({});
  ///
  /// ```
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user;
  bool isSignUp = false;
  bool isLoading = true;

  /// This is the class constructor that is calling to [_authCheck]
  AuthController() {
    _authCheck();
  }

  /// Consulting in [_firebaseAuth] and listening if the variable [user]
  /// is changed, and case if changed i use [notifyListeners] to change state
  /// of screen
  _authCheck() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  /// Consulting in [_firebaseAuth] the user is logged in app
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
