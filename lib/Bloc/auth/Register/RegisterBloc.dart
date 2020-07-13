import 'dart:async';

import 'package:foolife/Repository/AuthRepository.dart';

import 'package:rxdart/rxdart.dart';

import '../../basebloc.dart';
import 'RegisterValdiator.dart';


class RegisterBloc extends Object with RegisterValdiator implements BlocBase {
  
  final _email=BehaviorSubject<String>();
  final _password=BehaviorSubject<String>();
  final _confirmPassword=BehaviorSubject<String>();
  final _role=BehaviorSubject<int>();
  final _registerPressed=BehaviorSubject<bool>();
  final _phoneNumber=BehaviorSubject<String>();

//////
String token="";
int userid =-1;
//////////////////////////////sink(input)///////////////////////////////////////
  
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;
  Function(int) get changeRole => _role.sink.add;
  Function(bool) get submitRegister => _registerPressed.sink.add;
 Function(String) get changePhoneNumber => _phoneNumber.sink.add;
 
///////////////////////////stream(output)////////////////////////////////////////
 Stream<String> get emailStream => _email.stream.transform(validateRegisterEmail);
 Stream<String> get passwordStream => _password.stream.transform(validateRegisterPassword);
 Stream<String> get phoneNumberStream => _phoneNumber.stream;
 Stream<String> get conforimPasswordStream => _confirmPassword.stream.transform(StreamTransformer<String, String>.fromHandlers(
          handleData: (data, sink) async {
            if(data.length>=8){
            String lastPassword= await passwordStream.first;
            if(data==lastPassword)
           sink.add(data);
          else
          sink.addError("Password not match");
            }else
            {
                sink.addError("Password must be at least 8 charcters");
            }
      }));






Stream<bool> get submitRegisterStream => _registerPressed.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {

  
            String lastEmail=await  emailStream.first;
            String lastpassword = await passwordStream.first;
            int lastRole = await   roleStream.first;
            String lastConfirmPassword= await conforimPasswordStream.first; 
             String lastPhoneNumber= await phoneNumberStream.first; 
           
            
         var user =await  AuthRepository().register(lastEmail, lastpassword, lastConfirmPassword, lastRole,lastPhoneNumber);
            if(user!=null){

              print(user);
          sink.add(true);
          
            }else
          sink.addError("Something went wrong");

          

      }));


      Stream<int> get roleStream => _role.stream.transform(StreamTransformer<int, int>.fromHandlers(
          handleData: (data, sink) async {
         sink.add(data);
      }));

  /////////////////////////////////////////////////////////
   Stream<bool> get registerValid =>
      Rx.combineLatest4(emailStream, passwordStream,conforimPasswordStream, phoneNumberStream,(a, b,c,d) => true);    


      


 
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
    _password.close();
    _confirmPassword.close();
    _role.close();
    _registerPressed.close();
  }
}
