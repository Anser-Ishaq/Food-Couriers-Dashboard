import 'package:flutter/foundation.dart';
import 'package:food_couriers_dashboard/models/user_model.dart';
import 'package:food_couriers_dashboard/sevices/database_service.dart';
import 'package:get_it/get_it.dart';

class AdmindataProvider with ChangeNotifier {
  final DatabaseService _databaseService = GetIt.instance.get<DatabaseService>();
  List<UserModel> _admins = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<UserModel> get admins => _admins;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AdmindataProvider() {
    _fetchAdmins();
  }

  Future<void> _fetchAdmins() async {
    _setLoading(true);
    try {
      final List<UserModel> adminsList = await _databaseService.getAdmins();
      _setAdmins(adminsList);
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  void _setAdmins(List<UserModel> adminsList) {
    _admins = adminsList;
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
