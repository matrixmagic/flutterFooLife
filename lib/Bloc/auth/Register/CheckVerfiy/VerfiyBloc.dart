import 'dart:async';

import 'package:foolife/Bloc/auth/Register/CheckVerfiy/verfiyValidiator.dart';
import 'package:foolife/Repository/AuthRepository.dart';

import 'package:rxdart/rxdart.dart';

import '../../../basebloc.dart';
import '../RegisterValdiator.dart';



class VerfiyBloc extends Object with VerfiyValidiator implements BlocBase {
  
  final _email=BehaviorSubject<String>();
 final _activePressed=BehaviorSubject<int>();

//////

//////////////////////////////sink(input)///////////////////////////////////////
  
  Function(String) get changeEmail => _email.sink.add;
 Function(int) get changeActive => _activePressed.sink.add;

 
///////////////////////////stream(output)////////////////////////////////////////
 Stream<String> get emailStream => _email.stream.transform(validatVerfiedEmail);

Stream<int> get submitverfiedStream => _activePressed.stream.transform(StreamTransformer<int, int>.fromHandlers(
          handleData: (data, sink) async {

  
            String lastEmail=await  emailStream.first;
           
           
            
         int result =await  AuthRepository().isEmailVerfied(lastEmail);
            if(result!=null){

              print(result);
          sink.add(result);
          
            }else
          sink.addError("Something went wrong");

          

      }));



  /////////////////////////////////////////////////////////
  

      


 
  // Stream<bool> get registerStream =>
  //     _file.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
  //         handleData: (data, sink) async {
        
       
     
  //       FileRepository fileRepo = new FileRepository();
  //       var fileUploaded = await fileRepo.UploadFile(file);
  //       if(fileUploaded !=null)
  //       sink.add(true);
  //     }));


  @override
  void dispose() {
 
    _email.close();
  }
}
