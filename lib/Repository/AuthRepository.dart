import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';


import 'package:foolife/Dto/UserDto.dart';


import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class AuthRepository {
  ApiProvider api = new ApiProvider();
  Future<bool> login(String username, String password) async {
    AuthDto authDto = new AuthDto();
    authDto.email = username;
    authDto.password = password;
    var response = await api.post('auth/login', authDto.toJson());
    var data = ApiResponse.fromJson(json.decode(response.body));
  
    if (data.success == true) {
      final storage = new FlutterSecureStorage();
      UserDto user = UserDto.fromJson(data.data) ;
     var roleId = await storage.write(key: "_roleId", value: user.roleId.toString());
      var token = await storage.write(key: "_token", value: user.token);
      var userId = await storage.write(key: "_userId", value: user.id.toString());
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

   Future<UserDto> register(String email,String password,String confrim ,int role) async {
    AuthDto register = new AuthDto();
    register.email = email;
    register.password=password;
    register.passwordConfirmation=confrim;
    register.roleId=role;

    var response = await api.post('auth/register', register.toJson());
    var data = ApiResponse.fromJson(json.decode(response.body));
  
    if (data.success == true) {
     final storage = new FlutterSecureStorage();
      UserDto user = UserDto.fromJson(data.data) ;
      var roleId = await storage.write(key: "_roleId", value: user.roleId.toString());
      var token = await storage.write(key: "_token", value: user.token);
      var userId = await storage.write(key: "_userId", value: user.id.toString());
      return user;
    } else
      return null;
  }






}
