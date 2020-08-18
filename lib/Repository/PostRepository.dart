import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ChangeDisplayOrderDto.dart';
import 'package:foolife/Dto/HappyTimeDto.dart';
import 'package:foolife/Dto/PostDto.dart';
import 'package:foolife/Dto/ProductChangePriceDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/ProductExtraDto.dart';

import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class PostRepository {
  ApiProvider api = new ApiProvider();

  Future<bool> add(
    int fileId,

    String name,dynamic from,
      dynamic to,
    
      dynamic sunday,
      dynamic monday,
      dynamic tuesday,
      dynamic wednesday,
      dynamic thursday,
      dynamic friday,
      dynamic saturday,) async {
    try {
      PostDto postDto = new PostDto();

      postDto.name = name;
      postDto.from = from;
      postDto.to=to;
      postDto.saturday=saturday;
      postDto.sunday=sunday;
      postDto.monday=monday;
      postDto.tuesday=tuesday;
      postDto.wednesday=wednesday;
      postDto.thursday=thursday;
      postDto.friday=friday;
      postDto.fileId = fileId;
    
      var response = await api.post('post', postDto.toJson());
      print("post is added");
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
       
        return true;
      } else
        return false;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
      return false;
    }
  }

 
 
  Future<List<CategoryDto>> getAllCatetoriesAndProucts() async {
    try {
      var response = await api.get("getAllCatetoriesAndProucts");

      var data = ApiResponse.fromJson(json.decode(response.body));
      print("getAllCatetoriesAndProucts data ");
      print(data.codeMsg);
      if (data.success == true) {
        print("getAllCatetoriesAndProucts success ");
        List<CategoryDto> lst = new List<CategoryDto>();
        data.data.forEach((v) {
          lst.add(new CategoryDto.fromJson(v));
        });

        return lst;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

}
