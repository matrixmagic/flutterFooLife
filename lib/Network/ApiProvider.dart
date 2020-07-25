import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiProvider {
  final String _baseUrl = "http://www.insperry.com/api/";
  // final String _baseUrl = "http://10.0.0.1:8012/FooLife/public/api/";

  Future<Response> get(String url) async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: "_token");
      if (token == null || token == '') {
        var response = http.get(_baseUrl + url);
        return response;
      } else {
        final response = http.get(_baseUrl + url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Beareer $token',
        });
        return response;
      }
    } on SocketException {
      throw Exception;
    }
  }

  Future<dynamic> post(String url, dynamic body) async {
    var response;
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "_token");
    if (token == null || token == '') {
      response = await http.post(
        _baseUrl + url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body),
      );

      return response;
    } else {
      response = await http.post(
        _baseUrl + url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      return response;
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
    }
  }
}
