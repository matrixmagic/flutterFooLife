import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';

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
      else if (data.status == 412){
      RestaurantDto restaurant = RestaurantDto.fromJson(data.data);
        print(restaurant);
        final storage = new FlutterSecureStorage();
          var RestaurantName = await storage.write(
                            key: "_restaurantName",
                            value: restaurant.name);

        return 412;

      } 
    } catch (e) {
      // code for handling exception
    }
  }

  Future<bool> verifyRestaurant( String code) async {
    try {
      final storage = new FlutterSecureStorage();
      var body = {
        "email":await storage.read(key:"_verficationEmail" ),
        "code": code,
      };
      var response = await api.post('auth/verifyRestaurant', body);
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.status == 200) {
       await  storage.write(key: "_code", value: code);
        return true;
      } else if (data.status == 400) return false;
    } catch (e) {
      // code for handling exception
    }
  }
  Future<bool> changeRestaurantPassword(String password,String confPassword)async {
     final storage = new FlutterSecureStorage();
var body ={
  "email" : await storage.read(key:"_verficationEmail" ),
  "code" : await storage.read(key:"_code"),
  "newpassword":password,
  "newpassword_confirmation":confPassword
}; var response = await api.post('auth/changeRestaurantPassword', body);
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success  ) {
       
        return true;
      } else  return false;


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

  Future<void> loginByDeviceIdAsGuest() async {
  String result;
  var deviceInfo = DeviceInfoPlugin();
  final storage = new FlutterSecureStorage();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    result = iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    result = androidDeviceInfo.androidId; // unique ID on Android
  }
   var body = {
        "deviceId": result,
      };

var vaild =await CheckToken();
if(vaild){

   var role =await storage.read(key: "_roleId");
   if(role=="2")
   return ;
}
   var response = await api.post('auth/loginByDeviceIdAsGuest', body);
      var data = ApiResponse.fromJson(json.decode(response.body));
      
      if (data.success == true) {
        UserDto user = UserDto.fromJson(data.data);
        var roleId =
            await storage.write(key: "_roleId", value: user.roleId.toString());
        var token = await storage.write(key: "_token", value: user.token);
        var userId =
            await storage.write(key: "_userId", value: user.id.toString());
        print('say yaaaaaaaaaaaaaa '+user.roleId.toString());
        return true;
      } else
        await storage.delete(key: "_roleId");
      await storage.delete(key: "_token");
      await storage.delete(key: "_userId");
      print('ohh nooooooh');
      return false;
  
  print(result);
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
