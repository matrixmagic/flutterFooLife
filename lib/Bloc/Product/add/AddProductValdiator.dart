import 'dart:async';


class AddProductValdiator {
  StreamTransformer valdiator =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) async {
if(data.length>0)
sink.add(data);
else 
sink.addError("This field mustn't be empty");
   
  });
 StreamTransformer timeValdiator =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) async {
if(data.length>0 && data.length<6)
if(data.indexOf(":")==1|| data.indexOf(":")==2)
sink.add(data);
else
sink.addError("be like  13:00 or 8:30");
else 
sink.addError("be like  13:00 or 8:30");
   
  });
 
}
