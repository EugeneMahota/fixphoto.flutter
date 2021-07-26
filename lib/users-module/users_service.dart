import 'package:tirmobile/shared/models/user.dart';
import 'package:tirmobile/shared/services/api/web_api.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';

abstract class UsersServiceImpl {
  Future<List<User>> getUsers();
}

class UsersService implements UsersServiceImpl {
  final WebApi _webApi = serviceLocator<WebApi>();
  List<User> _users;

  @override
  Future<List<User>> getUsers() async {
    if (_users != null) {
      return _users;
    }

    return _users = await _webApi.getUsers();
  }
}
