import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/models/user_model.dart';
import 'package:food_couriers_dashboard/provider/auth_provider.dart';
import 'package:food_couriers_dashboard/sevices/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class UserdataProvider with ChangeNotifier {
  final DatabaseService _databaseService = GetIt.instance.get<DatabaseService>();
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  UserdataProvider(BuildContext context) {
    _initializeUserData(context);
  }

  void _initializeUserData(BuildContext context) async {
    _setLoading(true);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user != null) {
        final uid = authProvider.user!.uid;
        final user = await _databaseService.getUser(uid: uid);
        _setCurrentUser(user);
      }
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createUser(UserModel user) async {
    _setLoading(true);
    try {
      await _databaseService.createUser(user: user);
      _setCurrentUser(user);
      if (kDebugMode) print('User created successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser({String? newPhone}) async {
    _setLoading(true);
    try {
      final authProvider = GetIt.instance.get<AuthProvider>();
      final uid = authProvider.user!.uid;
      await _databaseService.updateUser(uid: uid, newPhone: newPhone);
      final updatedUser = await _databaseService.getUser(uid: uid);
      if (updatedUser != null) _setCurrentUser(updatedUser);
      if (kDebugMode) print('User updated successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteUser() async {
    _setLoading(true);
    try {
      final authProvider = GetIt.instance.get<AuthProvider>();
      final uid = authProvider.user!.uid;
      await _databaseService.deleteUser(uid: uid);
      _setCurrentUser(null);
      if (kDebugMode) print('User deleted successfully!');
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  void _setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleError(Object error) {
    _errorMessage = 'An error occurred: $error';
    if (kDebugMode) print(_errorMessage);
    notifyListeners();
  }
}
