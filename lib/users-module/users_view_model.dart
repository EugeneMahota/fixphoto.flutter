import 'package:flutter/material.dart';
import 'package:tirmobile/shared/models/user.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/users-module/users_service.dart';

class UsersViewModel extends ChangeNotifier {
  final UsersService _usersService = serviceLocator<UsersService>();
  List<User> _users = [];

  get users => _users;

  Future<void> loadData() async {
    await _getUsers();
    notifyListeners();
  }

  void clearData() {
    _users = [];
  }

  Future<void> _getUsers() async {
    _users = await _usersService.getUsers();
  }
}
