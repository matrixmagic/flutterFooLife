import 'dart:async';

import 'package:foolife/Repository/AuthRepository.dart';

class RegisterValdiator {
  StreamTransformer validateRegisterEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) async {
    AuthRepository auth =AuthRepository();
    if (data.contains("@"))
     if(await auth.isEmailExists(data))
       sink.add(data);
       else{
          sink.addError("Exists email");
       }
    else
      sink.addError("Not a valid E-mail");
  });
  StreamTransformer validateRegisterPassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length >= 8)
      sink.add(data);
    else
      sink.addError("Password must be at least 8 charcters");
  });
}
