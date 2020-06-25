import 'dart:async';
import 'dart:io';


import 'package:foolife/Repository/AuthRepository.dart';
import 'package:foolife/Repository/FileRepository.dart';

import 'package:rxdart/rxdart.dart';

import '../../basebloc.dart';
import 'RegisterValdiator.dart';


class RegisterBloc extends Object with RegisterValdiator implements BlocBase {
  final _file = BehaviorSubject<File>();
  final _email=BehaviorSubject<String>();
  final _password=BehaviorSubject<String>();
  final _confirmPassword=BehaviorSubject<String>();
  final _role=BehaviorSubject<int>();
  final _registerPressed=BehaviorSubject<bool>();
 

//////
String token="";
int userid =-1;
//////////////////////////////sink(input)///////////////////////////////////////
  Function(File) get changeFile => _file.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;
  Function(int) get changeRole => _role.sink.add;
  Function(bool) get submitRegister => _registerPressed.sink.add;
 
///////////////////////////stream(output)////////////////////////////////////////
 Stream<String> get emailStream => _email.stream.transform(validateRegisterEmail);
 Stream<String> get passwordStream => _password.stream.transform(validateRegisterPassword);
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
            File file = await fileStream.first;
            print("passs file await ");
            print("role id : "+lastRole.toString());
         var user =await  AuthRepository().register(lastEmail, lastpassword, lastConfirmPassword, lastRole);
            if(user!=null){

          if(file!=null)
          {
         var fileuploaded= await FileRepository().UploadFile(file, true);
          }
          if(user!=null)
          sink.add(true);
          else
          sink.addError("Something went wrong");

            }
      }));


      Stream<int> get roleStream => _role.stream.transform(StreamTransformer<int, int>.fromHandlers(
          handleData: (data, sink) async {
         sink.add(data);
      }));

  /////////////////////////////////////////////////////////
   Stream<bool> get registerValid =>
      Rx.combineLatest3(emailStream, passwordStream,conforimPasswordStream, (a, b,c) => true);    


      


 Stream<File> get fileStream =>
      _file.stream.transform(StreamTransformer<File, File>.fromHandlers(
          handleData: (data, sink) async {
          sink.add(data);
      }));

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
    _file.close();
    _email.close();
    _password.close();
    _confirmPassword.close();
    _role.close();
    _registerPressed.close();
  }
}
