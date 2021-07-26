import 'package:flutter/cupertino.dart';

class LoginResponse {
  String token;

  LoginResponse({@required this.token});

  factory LoginResponse.fromJson(json) {
    return new LoginResponse(
      token: json['token'] as String,
    );
  }
}
