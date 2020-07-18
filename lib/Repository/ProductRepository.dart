import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ChangeDisplayOrderDto.dart';
import 'package:foolife/Dto/ProductDto.dart';

import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class ProductRepository {
  ApiProvider api = new ApiProvider();

  Future<ProductDto> add(String name,double price,dynamic fileId,dynamic categoryId) async {
    try {
      ProductDto productDto = new ProductDto();
     
productDto.name=name;
productDto.price=price;
productDto.fileId=fileId;
productDto.categoryId=categoryId;


     
      var response = await api.post('product', productDto.toJson());
       print("add product");
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
         productDto = ProductDto.fromJson(data.data);
      
        print("cast data");
        return productDto;
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



  Future< List<ProductDto>> getProductsInSide(dynamic categoryId) async {
    try {
      ProductDto productDto = new ProductDto();
      productDto.categoryId = categoryId;
      var response = await api.post("getAllProductsInSide", productDto.toJson());

      var data = ApiResponse.fromJson(json.decode(response.body));
       print("waka wakaxzcxczxcx");
      if (data.success == true) {
        print("waka waka");
        List<ProductDto> lst = new List<ProductDto>();
        data.data.forEach((v) {
          lst.add(new ProductDto.fromJson(v));
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
      var response = await api.post("changeproductsDisplayOrder", changeDisplayOrderDto);

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
