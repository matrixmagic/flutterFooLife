import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ChangeDisplayOrderDto.dart';

import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class CategoryRepository {
  ApiProvider api = new ApiProvider();

  Future<CategoryDto> add(String name,dynamic parentCategoryId) async {
    try {
      CategoryDto categoryDto = new CategoryDto();
      categoryDto.name=name;
      categoryDto.parentCategoryId=parentCategoryId;

     
      var response = await api.post('category', categoryDto.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
         categoryDto = CategoryDto.fromJson(data.data);
        
        print("biiila");
        return categoryDto;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }


Future<CategoryDto> Edit(String name,dynamic id) async {
    try {
      CategoryDto categoryDto = new CategoryDto();
      categoryDto.name=name;
      categoryDto.id=id;

     
      var response = await api.post('categoryEdit', categoryDto.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
         categoryDto = CategoryDto.fromJson(data.data);
        
        print("channnge");
        return categoryDto;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }



  Future< List<CategoryDto>> getAllCatetoriesInSide(dynamic parentCategoryId) async {
    try {
      CategoryDto categoryDto = new CategoryDto();
      categoryDto.parentCategoryId = parentCategoryId;
      var response = await api.post("getAllCatetoriesInSide", categoryDto);

      var data = ApiResponse.fromJson(json.decode(response.body));
       print("waka wakaxzcxczxcx");
      if (data.success == true) {
        print("waka waka");
        List<CategoryDto> lst = new List<CategoryDto>();
        data.data.forEach((v) {
          lst.add(new CategoryDto.fromJson(v));
        });
        

        print("biiila");
        return lst;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future< bool> changeOrder(int id1, int id2) async {
    try {
      ChangeDisplayOrderDto  changeDisplayOrderDto = new ChangeDisplayOrderDto ();
      changeDisplayOrderDto.id1 = id1;
      changeDisplayOrderDto.id2=id2;
      var response = await api.post("changeDisplayOrder", changeDisplayOrderDto);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the order is change");
        return true;
      } else
        return false;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }


  
  Future< bool> delete(int id) async {
    try {
     CategoryDto categoryDto = new CategoryDto();
      categoryDto.id = id;
      var response = await api.post("categoryDelete", categoryDto);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the category is deleted");
        return true;
      } else
        return false;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

   
}
