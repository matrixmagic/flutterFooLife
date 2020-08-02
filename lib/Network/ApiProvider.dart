import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';

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
        final response = http.get(_baseUrl + url,   headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },);
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


Future<dynamic> postMultiFile(String url, dynamic body,String filePath,String fileId) async {
    var response;
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "_token");
    if (token == null || token == '') {


 var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + url,),);
 request.fields.addAll(<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },);
        request.fields.addAll(<String, String>{
          'body': json.encode(body),
        },);

  request.files.add(
    await http.MultipartFile.fromPath(
      fileId,
      filePath
    )
  );

  response = await request.send();
  return response;
}

     else {


       var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + url,),);
 request.fields.addAll(<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },);
        request.fields.addAll(<String, String>{
          'body': json.encode(body),
        },);

        request.fields.addAll(<String,String>{
           'Authorization': 'Bearer $token'
        });

  request.files.add(
    await http.MultipartFile.fromPath(
      fileId,
      filePath
    )
  );

  response = await request.send();
  return response;

    
    }
  }



Future<http.Response> uploadFile(String url,File _file,int isMain) async {

final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "_token");
 
    // open a byteStream
    var stream = new http.ByteStream(_file.openRead());
    // get file length
    var length = await _file.length();

    // string to uri
    var uri = Uri.parse( _baseUrl + url);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
       if (token != null || token != '') 
    {
      request.headers["Authorization"] = "Bearer $token";

   }

    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request

    request.fields["isMain"] = isMain.toString();
    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(_file.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send request to upload image
   var response=  await request.send();
   var response2 = await http.Response.fromStream(response);

  return response2;
  }


}
