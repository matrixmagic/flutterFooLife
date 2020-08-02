import 'dart:async';
import 'package:string_validator/string_validator.dart';

class PriceProductValdiator {
  StreamTransformer valdiator =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) async {
if(data.length>0)
if( ( data[0]=='-'|| data[0]=='+') && isFloat(data.substring(1)))
sink.add(data);
else 
sink.addError("Its not correct input");

   
  });

 
}
