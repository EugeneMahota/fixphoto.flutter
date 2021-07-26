import 'package:tirmobile/shared/models/login_response.dart';

import 'api/web_api.dart';
import 'core/service_locator.dart';

abstract class _AuthService {
  Future<LoginResponse> login(String email, String password);
}

class AuthService implements _AuthService {
  WebApi _webApi = serviceLocator<WebApi>();

  @override
  Future<LoginResponse> login(String login, String password) {
    return _webApi.login(login, password);
  }
}
