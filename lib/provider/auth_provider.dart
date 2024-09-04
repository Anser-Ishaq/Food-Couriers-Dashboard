import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_couriers_dashboard/sevices/auth_service.dart';
import 'package:get_it/get_it.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = GetIt.instance.get<AuthService>();
  late final StreamSubscription<User?> _authStateSubscription;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _initializeAuthState();
  }

  void _initializeAuthState() {
    _authStateSubscription = _authService.authStateChanges.listen(_setUser);
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _setUser(user);
        if (kDebugMode) print('Sign in successful!');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      if (kDebugMode) print(_errorMessage);
    } finally {
      _setLoading(false);
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        _setUser(user);
        if (kDebugMode) print('Sign up successful!');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      if (kDebugMode) print(_errorMessage);
    } finally {
      _setLoading(false);
    }
    return false;
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _setUser(null);
      if (kDebugMode) print('Sign out successful!');
    } catch (e) {
      _errorMessage = 'An error occurred during sign out: ${e.toString()}';
      if (kDebugMode) print(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resetPassword(String email) async {
    _setLoading(true);
    try {
      await _authService.sendPasswordResetEmail(email);
      if (kDebugMode) print('Password reset email sent.');
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      if (kDebugMode) print(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    _setLoading(true);
    try {
      if (_user != null) {
        await _authService.changePassword(_user!, oldPassword, newPassword);
        if (kDebugMode) print('Password change successful!');
        return true;
      } else {
        _errorMessage = 'No user is currently signed in.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred while changing password: ${e.toString()}';
      if (kDebugMode) print(_errorMessage);
    } finally {
      _setLoading(false);
    }
    return false;
  }

  void _setUser(User? user) {
    _user = user;
    _isLoading = false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        _errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        _errorMessage = 'Wrong password provided.';
        break;
      case 'weak-password':
        _errorMessage = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        _errorMessage = 'The account already exists for that email.';
        break;
      default:
        _errorMessage = 'Error: ${e.message}';
    }
    if (kDebugMode) print(_errorMessage);
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}
