import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';

import 'package:foolife/Dto/UserDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class AuthRepository {
  ApiProvider api = new ApiProvider();
  Future<bool> login(String username, String password) async {
    try {
      AuthDto authDto = new AuthDto();
      authDto.email = username;
      authDto.password = password;
      var response = await api.post('auth/login', authDto.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      final storage = new FlutterSecureStorage();
      if (data.success == true) {
        UserDto user = UserDto.fromJson(data.data);
        var roleId =
            await storage.write(key: "_roleId", value: user.roleId.toString());
        var token = await storage.write(key: "_token", value: user.token);
        var userId =
            await storage.write(key: "_userId", value: user.id.toString());
        return true;
      } else
        await storage.delete(key: "_roleId");
      await storage.delete(key: "_token");
      await storage.delete(key: "_userId");
      return false;
    } catch (e) {
      // code for handling exception
    }
  }

  Future<bool> isEmailExists(String email) async {
    try {
      AuthDto log = new AuthDto();
      log.email = email;
      var response = await api.post('auth/IsEmailExists', log.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        return true;
      } else
        return false;
    } catch (e) {
      // code for handling exception
    }
  }

  Future<int> isEmailVerfied(String email) async {
    try {
      AuthDto log = new AuthDto();
      log.email = email;
      var response = await api.post('auth/IsEmailVerify', log.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.status == 200) {
        return 200;
      } else if (data.status == 411)
        return 411;
      else if (data.status == 400)
        return 400;
      else if (data.status == 412) return 412;
    } catch (e) {
      // code for handling exception
    }
  }

  Future<bool> verifyRestaurant(String email, String code) async {
    try {
      var body = {
        "email": email,
        "code": code,
      };
      var response = await api.post('auth/verifyRestaurant', body);
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.status == 200) {
        return true;
      } else if (data.status == 400) return false;
    } catch (e) {
      // code for handling exception
    }
  }

  Future<UserDto> register(String email, String password, String confrim,
      int role, String phoneNumber) async {
    try {
      AuthDto register = new AuthDto();
      register.email = email;
      register.password = password;
      register.passwordConfirmation = confrim;
      register.roleId = role;
      register.phoneNumber = phoneNumber;
      var response = await api.post('auth/register', register.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      final storage = new FlutterSecureStorage();
      if (data.success == true) {
        UserDto user = UserDto.fromJson(data.data);
        var roleId =
            await storage.write(key: "_roleId", value: user.roleId.toString());
        var token = await storage.write(key: "_token", value: user.token);
        var userId =
            await storage.write(key: "_userId", value: user.id.toString());
        return user;
      } else
        await storage.delete(key: "_roleId");
      await storage.delete(key: "_token");
      await storage.delete(key: "_userId");
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> CheckToken() async {
    try {
      print('checktoken begain');
      var response = await api.post('auth/checkToken', null);
      var data = ApiResponse.fromJson(json.decode(response.body));
      final storage = new FlutterSecureStorage();
      if (data.success == true) {
        UserDto user = UserDto.fromJson(data.data);
        var roleId =
            await storage.write(key: "_roleId", value: user.roleId.toString());
        var token = await storage.write(key: "_token", value: user.token);
        var userId =
            await storage.write(key: "_userId", value: user.id.toString());
        print('say yaaaa');
        return true;
      } else
        await storage.delete(key: "_roleId");
      await storage.delete(key: "_token");
      await storage.delete(key: "_userId");
      print('ohh nooooooh');
      return false;
    } catch (e) {
      print(e);
      // code for handling exception
    }
  }
}
