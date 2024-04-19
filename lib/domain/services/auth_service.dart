// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase authentication library
import 'package:hotel/domain/models/user_model.dart'; // Import user model
import 'package:awesome_dialog/awesome_dialog.dart'; // Import Awesome Dialog library
import 'package:flutter/material.dart'; // Import Flutter material library

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase authentication instance

  // Create user with email and password
  Future<UserModel?> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ); // Create user with email and password
      User? user = userCredential.user; // Get user from user credential
      return UserModel(uid: user?.uid, email: user?.email); // Return UserModel
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      String errorMessage = '';
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.'; // Weak password error
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.'; // Email already in use error
          break;
        default:
          errorMessage = 'An error occurred while creating the user.'; // Default error message
      }
      // Show error message dialog
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
      return null;
    }
  }

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); // Sign in with email and password
      User? user = userCredential.user; // Get user from user credential
      return UserModel(uid: user?.uid, email: user?.email); // Return UserModel
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      String errorMessage = '';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with that email.'; // User not found error
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.'; // Wrong password error
          break;
        default:
          errorMessage = 'An error occurred while signing in.'; // Default error message
      }
      // Show error message dialog
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
      return null;
    }
  }
}
