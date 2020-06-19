import 'dart:async';

class AuthValdiator {
  StreamTransformer validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.contains("@"))
      sink.add(data);
    else
      sink.addError("Not a valid E-mail");
  });
  StreamTransformer validatepass =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length >= 8)
      sink.add(data);
    else
      sink.addError("Password must be at least 8 charcters");
  });
}
