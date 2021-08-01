import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/services/auth_service.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';

class LoginViewModel extends ChangeNotifier {
  AuthService service = serviceLocator<AuthService>();

  String _login;
  String _password;
  bool isLoading = false;

  void initForm(loginController, passwordController) {
    _login = loginController.text;
    _password = passwordController.text;
  }

  Future<void> login(context) async {
    if (isLoading) {
      return;
    }
    _startLoading();
    try {
      if (_login == '' || _password == '') {
        throw 'Введите логин и пароль!';
      }
      final loginResponse = await service.login(_login, _password);
      if (loginResponse?.token == null) {
        throw 'Ошибка авторизации!';
      }
      Navigator.pushNamed(context, '/tasks');
    } catch (error) {
      showError(context, error);
    }
    _finishLoading();
  }

  void showError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors().backgroundRedError,
        content: Text(errorMessage),
      ),
    );
  }

  void loginListener(TextEditingController controller) {
    _login = controller.text;
  }

  void passwordListener(TextEditingController controller) {
    _password = controller.text;
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _finishLoading() {
    isLoading = false;
    notifyListeners();
  }
}
