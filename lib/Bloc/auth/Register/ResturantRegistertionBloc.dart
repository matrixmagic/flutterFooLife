import 'dart:async';
import 'dart:io';




import 'package:rxdart/rxdart.dart';

import '../../basebloc.dart';

import 'ResturantRegisterValdiator.dart';


class ResturantRegistertionBloc extends Object with ResturantRegisterValdiator implements BlocBase {
  
  final _resturantName=BehaviorSubject<String>();
  final _address=BehaviorSubject<String>();
  final _street=BehaviorSubject<String>();
  final _city=BehaviorSubject<String>();
  final _fax=BehaviorSubject<String>();
  final _registerPressed=BehaviorSubject<bool>();
  final _file = BehaviorSubject<File>();
  final _opentime=BehaviorSubject<String>();
  final _closetime=BehaviorSubject<String>();
////
//////////////////////////////sink(input)///////////////////////////////////////
  Function(File) get changeFile => _file.sink.add;
  Function(String) get changeResturantName => _resturantName.sink.add;
  Function(String) get changeAddress => _address.sink.add;
  Function(String) get changeStreet => _street.sink.add;
  Function(String) get changeCity => _city.sink.add;
  Function(String) get changeFax => _fax.sink.add;
Function(bool) get submitRegister => _registerPressed.sink.add;
 Function(String) get changeOpenTime => _opentime.sink.add;
 Function(String) get changeCloseTime => _closetime.sink.add;
///////////////////////////stream(output)////////////////////////////////////////
 Stream<String> get resturantNameStream => _resturantName.stream.transform(valdiator);
 Stream<String> get addressStream => _address.stream.transform(valdiator);
 Stream<String> get streetStream => _street.stream.transform(valdiator);
 Stream<String> get cityStream => _city.stream.transform(valdiator);
Stream<String> get faxStream => _fax.stream.transform(valdiator);
Stream<String> get openTimeStream => _opentime.stream.transform(timeValdiator);
Stream<String> get closeTimeStream => _closetime.stream.transform(timeValdiator);
 Stream<File> get fileStream =>_file.stream;





Stream<bool> get submitRegisterStream => _registerPressed.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {

  
            String lastResturantName=await  resturantNameStream.first;
            String lastAddress = await addressStream.first;
            String lastStreet = await   streetStream.first;
            String lastCity= await cityStream.first; 
             String lastFax= await faxStream.first; 
             String lastOpenTime= await openTimeStream.first;
              String lastCloseTime= await closeTimeStream.first;
             File lastfile = await fileStream.first;
        
        // var user =await  AuthRepository().register(lastEmail, lastpassword, lastConfirmPassword, lastRole,lastPhoneNumber);
          //  if(user!=null){

          
       //   if(user!=null)
         // sink.add(true);
          //else
          //sink.addError("Something went wrong");

           // }
      }));


  

  /////////////////////////////////////////////////////////
  // Stream<bool> get registerValid =>
    //  Rx.combineLatest4(emailStream, passwordStream,conforimPasswordStream, phoneNumberStream,(a, b,c,d) => true);    


      


 
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
 
    _resturantName.close();
    _address.close();
    _street.close();
    _city.close();
    _registerPressed.close();
_fax.close();
_opentime.close();
_closetime.close();
  }
}
