// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase authentication library
import 'package:hotel/domain/models/user_model.dart'; // Import user model
import 'package:awesome_dialog/awesome_dialog.dart'; // Import Awesome Dialog library
import 'package:flutter/material.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';// Import Flutter material library

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create user with email and password
  Future<UserModel?> createUserWithEmailAndPassword(BuildContext context,
      String email, String password, String displayName) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      //debugPrint('user: $user');
      final userModel = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        displayName: displayName,
      );
      // Create a new user document in Firestore
      try {
        await _firestore
            .collection('users')
            .doc(user!.uid)
            .set(userModel.toJson());
        debugPrint('done');
      } catch (e) {
        // Handle Firestore error
        debugPrint('Error creating user document: $e');
        rethrow;
      }
      return UserModel(
          uid: user.uid, email: user.email ?? '', displayName: displayName);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      String errorMessage = '';
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        default:
          errorMessage = 'An error occurred while creating the user.';
      }      // Show error message dialog
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
      return UserModel(uid: user?.uid, email: user?.email, displayName: ''); // Return UserModel
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

  signOut(BuildContext context) {}
}
