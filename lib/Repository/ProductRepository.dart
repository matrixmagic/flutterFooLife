import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ChangeDisplayOrderDto.dart';
import 'package:foolife/Dto/HappyTimeDto.dart';
import 'package:foolife/Dto/ProductChangePriceDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/ProductExtraDto.dart';

import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class ProductRepository {
  ApiProvider api = new ApiProvider();

  Future<ProductDto> add(String name, double price, dynamic fileId,
      dynamic typeId, dynamic categoryId, String details) async {
    try {
      ProductDto productDto = new ProductDto();

      productDto.name = name;
      productDto.price = price;
      productDto.fileId = fileId;
      productDto.categoryId = categoryId;
      productDto.details = details;
      productDto.typeId = typeId;

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

  Future<ProductExtraDto> addExtra(int productId) async {
    try {
      ProductExtraDto productExtraDto = new ProductExtraDto();
      productExtraDto.productId = productId;

      var response = await api.post('productExtra', productExtraDto.toJson());
      print("add productExtra");
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        productExtraDto = ProductExtraDto.fromJson(data.data);

        print("cast data");
        return productExtraDto;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<CategoryDto> Edit(String name, dynamic id) async {
    try {
      CategoryDto categoryDto = new CategoryDto();
      categoryDto.name = name;
      categoryDto.id = id;

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

  Future<List<ProductDto>> getProductsInSide(dynamic categoryId) async {
    try {
      ProductDto productDto = new ProductDto();
      productDto.categoryId = categoryId;
      var response =
          await api.post("getAllProductsInSide", productDto.toJson());

      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("getAllProductsInSide success ");
        List<ProductDto> lst = new List<ProductDto>();
        data.data.forEach((v) {
          lst.add(new ProductDto.fromJson(v));
        });

        return lst;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
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

  Future<bool> changeOrder(int id1, int id2) async {
    try {
      ChangeDisplayOrderDto changeDisplayOrderDto = new ChangeDisplayOrderDto();
      changeDisplayOrderDto.id1 = id1;
      changeDisplayOrderDto.id2 = id2;
      var response =
          await api.post("changeproductsDisplayOrder", changeDisplayOrderDto);

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

  Future<ProductDto> changePrice(int id, double price) async {
    try {
      ProductChangePriceDto productChangePriceDto = new ProductChangePriceDto();
      productChangePriceDto.id = id;
      productChangePriceDto.price = price;

      var response = await api.post("changePrice", productChangePriceDto);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the price is change");
        return ProductDto.fromJson(data.data);
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<ProductDto> changeContent(int id, String content) async {
    try {
      var body = {
        "id": id,
        "content": content,
      };

      var response = await api.post("changeProductContent", body);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the content is change");
        return ProductDto.fromJson(data.data);
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<ProductExtraDto> changeExtraContent(int id, String content) async {
    try {
      var body = {
        "id": id,
        "content": content,
      };

      var response = await api.post("changeContentproductExtra", body);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the extra content is change");
        return ProductExtraDto.fromJson(data.data);
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<ProductExtraDto> changeExtraPrice(int id, double price) async {
    try {
      ProductChangePriceDto productChangePriceDto = new ProductChangePriceDto();
      productChangePriceDto.id = id;
      productChangePriceDto.price = price;

      var response = await api.post("changeExtraPrice", productChangePriceDto);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the extra price is change");
        return ProductExtraDto.fromJson(data.data);
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<bool> delete(int id) async {
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

  Future<bool> ChangeporductsAllPrice(String statement) async {
    try {
      var body = {
        "statement": statement,
      };

      var response = await api.post("changePriceِForAllporducts", body);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the all prices is change");
        return true;
      } else
        return false;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
      return false;
    }
  }

  Future<bool> AllporductCateegoryChangePrice(
      int categoryId, String statement) async {
    try {
      var body = {
        "statement": statement,
        "category_id": categoryId,
      };

      var response = await api.post("changePriceِForAllporductCateegory", body);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the all prices for category is change");
        return true;
      } else
        return false;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
      return false;
    }
  }

  Future<bool> addHappytime(
      String from,
      String to,
      String amount,
      int sunday,
      int monday,
      int tuesday,
      int wednesday,
      int thursday,
      int friday,
      int saturday,
      List<int> productIds,
      int categoryId) async {
    try {
      HappyTimeDto happyTimeDto = new HappyTimeDto();
      happyTimeDto.from = from;
      happyTimeDto.to = to;
      happyTimeDto.amount = amount;
      happyTimeDto.sunday = sunday;
      happyTimeDto.monday = monday;
      happyTimeDto.tuesday = tuesday;
      happyTimeDto.wednesday = wednesday;
      happyTimeDto.thursday = thursday;
      happyTimeDto.friday = friday;
      happyTimeDto.saturday = saturday;
      happyTimeDto.productIds = productIds;
      happyTimeDto.categoryId = categoryId;

      var response = await api.post("productHappyTime", happyTimeDto);

      var data = ApiResponse.fromJson(json.decode(response.body));
      print(data.data);
      if (data.success == true) {
        print("the happy time is change");
        return true;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<List<ProductDto>> getAllFoodsPaging(int pageIndex, int pageSize) async {
    try {
    var body ={
      "pageIndex": pageIndex,
      "pageSize": pageSize
    };


      var response = await api.post("getAllFoodsPaging",body);

      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("foods returned successfully");

        List<ProductDto> lst = new List<ProductDto>();
        data.data.forEach((v) {
          lst.add(new ProductDto.fromJson(v));
        });

        return lst;
      } else
        print("get nothing");
      return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<List<ProductDto>> getAllDrinksPaging(int pageIndex, int pageSize) async {
    try {
    var body ={
      "pageIndex": pageIndex,
      "pageSize": pageSize
    };


      var response = await api.post("getAllDrinksPaging",body);

      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("drinks returned successfully");

        List<ProductDto> lst = new List<ProductDto>();
        data.data.forEach((v) {
          lst.add(new ProductDto.fromJson(v));
        });

        return lst;
      } else
        print("get nothing");
      return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

}
