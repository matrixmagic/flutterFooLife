import 'dart:async';

import 'package:foolife/Repository/AuthRepository.dart';

class VerfiyValidiator {
  StreamTransformer validatVerfiedEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) async {
    AuthRepository auth =AuthRepository();
    if (data.contains("@"))
    
       sink.add(data);
     
    else
      sink.addError("Not a valid E-mail");
  });
 
}
