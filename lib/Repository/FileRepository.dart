import 'dart:convert';
import 'dart:io';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Models/FileUploaded.dart';
import 'package:foolife/Network/ApiProvider.dart';

class FileRepository{
 ApiProvider api = new ApiProvider();
  
 Future<FileUploaded> UploadFile(File file,bool isMain) async {
String fileName = file.path.split('/').last;
String base64Image = base64Encode(await file.readAsBytesSync());

var body ={
      "file": base64Image,
      "fileName": fileName,
      "isMain":isMain
    };

    var response =await api.post('file', body);
     var data = ApiResponse.fromJson(json.decode(response.body));
    if(data.success){

      var file = FileUploaded.fromJson(data.data) ;
      return file;
    }
    return null;

  }



}