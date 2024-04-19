import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:hotel/domain/services/auth_service.dart'; // Import authentication service
import 'package:hotel/domain/models/user_model.dart'; // Import user model

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService(); // Authentication service instance
  UserModel? _user; // Current user
  String? _errorMessage; // Error message
  bool _isLoggedIn = false; // Track login status

  UserModel? get user => _user; // Getter for current user
  String? get errorMessage => _errorMessage; // Getter for error message
  bool get isLoggedIn => _isLoggedIn; // Getter for login status

  // Create user with email and password
  Future<void> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    UserModel? createdUser = await _authService.createUserWithEmailAndPassword(
        context, email, password);
    if (createdUser != null) {
      _user = createdUser;
      _errorMessage = null;
      _isLoggedIn = true; // Set isLoggedIn to true after successful sign up
      notifyListeners();
    } else {
      _errorMessage = "An error occurred while creating the user.";
      notifyListeners();
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    UserModel? signedInUser =
        await _authService.signInWithEmailAndPassword(context, email, password);
    if (signedInUser != null) {
      _user = signedInUser;
      _errorMessage = null;
      _isLoggedIn = true; // Set isLoggedIn to true after successful sign in
      notifyListeners();
    } else {
      _errorMessage = "An error occurred while signing in.";
      notifyListeners();
    }
  }
}
