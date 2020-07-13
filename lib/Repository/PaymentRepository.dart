import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/MutiSelectDataSourceDto.dart';

import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';


import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class PaymentRepository {
  ApiProvider api = new ApiProvider();


  Future<List<Object>> GetAll()  async {
    try {
      var response = await api.get('payment');
      var data = ApiResponse.fromJson(json.decode(response.body));
     
       
      if (data.success == true) {
      // List<MutiSelectDataSourceDto> lst=new  List<MutiSelectDataSourceDto>();    
      //   data.data.forEach((v) {
      //   lst.add(new MutiSelectDataSourceDto.fromJson(v));
      // });
      // print(lst[0].value);
     
        
        return data.data;
      } else
      return null;
    } catch (e) {
    
      print(e.toString());
    }
  }

    
}
