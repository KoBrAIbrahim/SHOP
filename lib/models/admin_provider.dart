import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mainapp/models/admin.dart';
import 'package:mainapp/service/api_service.dart';

class AdminProvider extends ChangeNotifier {
  List<Admin> _admins = [];
  bool _showActive = true;

  List<Admin> get admins => _admins
      .where((admin) => admin.status == (_showActive ? 'active' : 'inactive'))
      .toList();

  bool get showActive => _showActive;

  final ApiService apiService = ApiService(Dio());

  Future<void> fetchAdmins() async {
    try {
      final response = await Dio().get("https://gorest.co.in/public-api/users");

      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('data')) {
        List<dynamic> users = response.data['data'] as List<dynamic>;

        _admins = users
            .map((user) => Admin.fromJson(user as Map<String, dynamic>))
            .toList();

        notifyListeners();
      } else {
        print("Unexpected API response format.");
      }
    } catch (e) {
      print("API Fetch Error: $e");
    }
  }

  void toggleStatus(bool isActive) {
    _showActive = isActive;
    notifyListeners();
  }
}
