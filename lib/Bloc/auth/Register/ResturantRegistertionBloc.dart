import 'dart:async';
import 'dart:io';




import 'package:foolife/Repository/RestaurantRepository.dart';
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
final _accessible=BehaviorSubject<int>();
final _childfriendly=BehaviorSubject<int>();
final _gamepad=BehaviorSubject<int>();
 final _wifi=BehaviorSubject<int>();
 final _power=BehaviorSubject<int>();
 final _pets=BehaviorSubject<int>();
 final _payments=BehaviorSubject<List<int>>();
  
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

  Function(int) get changeAccessible => _accessible.sink.add;
  Function(int) get changeChildfriendly => _childfriendly.sink.add;
  Function(int) get changeGamepad => _gamepad.sink.add;
  Function(int) get changeWifi => _wifi.sink.add;
  Function(int) get changePower => _power.sink.add;
  Function(int) get changePets => _pets.sink.add;

 Function(List<int>) get changePayments => _payments.sink.add;

///////////////////////////stream(output)////////////////////////////////////////
 Stream<String> get resturantNameStream => _resturantName.stream.transform(valdiator);
 Stream<String> get addressStream => _address.stream.transform(valdiator);
 Stream<String> get streetStream => _street.stream.transform(valdiator);
 Stream<String> get cityStream => _city.stream.transform(valdiator);
 Stream<String> get faxStream => _fax.stream.transform(valdiator);
 Stream<String> get openTimeStream => _opentime.stream.transform(timeValdiator);
 Stream<String> get closeTimeStream => _closetime.stream.transform(timeValdiator);
 Stream<File> get fileStream =>_file.stream;
 
 Stream<int> get accessibleStream =>_accessible.stream;
 Stream<int> get childfriendlyStream =>_childfriendly.stream;
 Stream<int> get gamepadStream =>_gamepad.stream;
 Stream<int> get wifiStream =>_wifi.stream;
 Stream<int> get powerStream =>_power.stream;
 Stream<int> get petsStream =>_pets.stream;

 Stream<List<int>> get paymentStream => _payments.stream;




Stream<bool> get submitRegisterStream => _registerPressed.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {

  
            String lastResturantName=await  resturantNameStream.first;
            String lastAddress = await addressStream.first;
            String lastStreet = await   streetStream.first;
            print("1");
            String lastCity= await cityStream.first; 
            String lastFax= await faxStream.first; 
            print("2");
            String lastOpenTime= await openTimeStream.first;
            String lastCloseTime= await closeTimeStream.first;
            print("3");
           // File lastfile = await fileStream.first;

            int lastAccessible= await accessibleStream.first;
            int lastChildfriendly= await childfriendlyStream.first;
            int lastGamepad = await gamepadStream.first;
              print("4");
            int lastWifi = await wifiStream.first;
            int lastPower = await powerStream.first;
              print("5");
            int lastPets = await petsStream.first;
            List<int> lastPayments =await paymentStream.first;
        print("6");
        print(lastPayments.toString());
         var restaurant =await  RestaurantRepository().add(lastResturantName, lastAddress, lastCity,
          lastStreet, lastFax, lastOpenTime, lastCloseTime,
          lastAccessible, lastChildfriendly, lastGamepad, lastWifi,
          lastPower, lastPets ,lastPayments
          );
             print("7");
           if(restaurant!=null){
   
             sink.add(true);
             print('added reg bloc suc');
            } else{
              print('expetion in registeration restuarant bloc');
          sink.addError("Something went wrong in registeration bloc");
            }
           
      }));


  

  /////////////////////////////////////////////////////////
  Stream<bool> get registerValid =>
     Rx.combineLatest5(resturantNameStream ,openTimeStream, closeTimeStream,
     cityStream,streetStream,(a, b,c,d,e) => true);    


      


 
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
