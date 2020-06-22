import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/LoginDto.dart';
import 'package:foolife/Dto/SuccessfulLogin.dart';
import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class AuthRepository {
  ApiProvider api = new ApiProvider();
  Future<bool> login(String username, String password) async {
    LoginDto log = new LoginDto();
    log.email = username;
    log.password = password;
    var res = await api.post('auth/login', log.toJson());
    var d = ApiResponse.fromJson(json.decode(res.body));
  
    if (d.success == true) {
      final storage = new FlutterSecureStorage();
      var data = SuccessfulLogin.fromJson(d.data) ;
     // var data = d.data as SuccessfulLogin;
      var token = await storage.write(key: "_token", value: data.accessToken);
      return true;
    } else
      return false;
  }
}
