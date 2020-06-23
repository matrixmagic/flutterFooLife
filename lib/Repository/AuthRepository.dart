import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';

import 'package:foolife/Dto/SuccessfulLogin.dart';
import 'package:foolife/Dto/successfulRegisterDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class AuthRepository {
  ApiProvider api = new ApiProvider();
  Future<bool> login(String username, String password) async {
    AuthDto log = new AuthDto();
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

  Future<bool> isEmailExists(String email) async {
    AuthDto log = new AuthDto();
    log.email = email;
  
    var response = await api.post('auth/IsEmailExists', log.toJson());
    var data = ApiResponse.fromJson(json.decode(response.body));
  
    if (data.success == true) {
    
      return true;
    } else
      return false;
  }

   Future<SuccessfulRegisterDto> register(String email,String password,String confrim ,int role) async {
    AuthDto register = new AuthDto();
    register.email = email;
    register.password=password;
    register.passwordConfirmation=confrim;
    register.roleId=role;
    print("register repooo say hello");
    var response = await api.post('auth/register', register.toJson());
    var data = ApiResponse.fromJson(json.decode(response.body));
  
    if (data.success == true) {
     final storage = new FlutterSecureStorage();
      SuccessfulRegisterDto user = SuccessfulRegisterDto.fromJson(data.data) ;
    
      var token = await storage.write(key: "_token", value: user.token);
      var userid = await storage.write(key: "_userId", value: user.id.toString());
      return user;
    } else
      return null;
  }






}
