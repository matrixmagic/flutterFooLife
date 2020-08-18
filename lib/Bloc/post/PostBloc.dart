import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foolife/Repository/AuthRepository.dart';
import 'package:foolife/Repository/FileRepository.dart';
import 'package:foolife/Repository/PostRepository.dart';

import 'package:rxdart/rxdart.dart';


import '../basebloc.dart';



class PostBloc extends Object implements BlocBase {
  Function close_it;
  PostBloc({this.close_it});
  final _sat = BehaviorSubject<int>();
  final _mon = BehaviorSubject<int>();
  final _tus = BehaviorSubject<int>();
  final _son = BehaviorSubject<int>();
  final _wed = BehaviorSubject<int>();
  final _fri = BehaviorSubject<int>();
  final _thur = BehaviorSubject<int>();
final _name = BehaviorSubject<String>();
  final _from = BehaviorSubject<TimeOfDay>();
  final _to = BehaviorSubject<TimeOfDay>();
 final _image=BehaviorSubject<File>();
  final _submit=PublishSubject<bool>();


//////////////////////////////sink(input)///////////////////////////////////////
  
  Function(String) get changeName => _name.sink.add;
   Function(int) get changeSat => _sat.sink.add;
  Function(int) get changeMon => _mon.sink.add;
  Function(int) get changeTus => _tus.sink.add;
  Function(int) get changeThurt => _thur.sink.add;
  Function(int) get changeWed => _wed.sink.add;
  Function(int) get changeSon => _son.sink.add;
  Function(int) get changefri => _fri.sink.add;
  Function(TimeOfDay) get changeTo => _to.sink.add;
  Function(TimeOfDay  ) get changefrom => _from.sink.add;
  Function(File) get changeImage => _image.sink.add;
  Function(bool) get changeSubmit => _submit.sink.add;

 
///////////////////////////stream(output)////////////////////////////////////////
 
  Stream<int> get satStream => _sat.stream;
  Stream<int> get sonStream => _son.stream;
  Stream<int> get monStream => _mon.stream;
  Stream<int> get thurStream => _thur.stream;
  Stream<int> get tusStream => _tus.stream;
  Stream<int> get wedStream => _wed.stream;
  Stream<int> get friStream => _fri.stream;
  Stream<TimeOfDay> get fromStream => _from.stream;
  Stream<TimeOfDay> get toStream => _to.stream;
    Stream<String> get nameStream => _name.stream;
 Stream<File> get imageStream => _image.stream;




Stream<bool> get submitStream => _submit.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {

  
             TimeOfDay lastFrom = await _from.first;
          TimeOfDay lastTo = await _to.first;
        
       File lastImage= await _image.first;
       String lastName= await _name.first;
          int lastSat = await _sat.first;
          int lastMon = await _mon.first;
          int lastSon = await _son.first;
          int lastThur = await _thur.first;
        
          int lastTus = await _tus.first;
          int lastWed = await _wed.first;
          int lastfri = await _fri.first; 
           
            
         var file =await  FileRepository().UploadFile2(lastImage,0);
            if(file!=null){
await PostRepository().add(file.id, lastName,lastFrom==null?null: lastFrom.hour.toString()+":"+lastFrom.minute.toString(),lastTo==null?null :lastTo.hour.toString()+":"+lastTo.minute.toString(), lastSon, lastMon,lastTus,lastWed, lastThur, lastfri, lastSat);
              print('file sucessfuly');
          sink.add(true);
          sink.close();
        
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                                     // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                    
 print('gooogooogogogoghhh');
                          close_it.call();
                        });
              
        
            }else
          sink.addError("Something went wrong");

          

      }));


     


 
  //   @override
  void dispose() {
 
   _name.close();
   _from.close();
   _to.close();
   _sat.close();
   _son.close();
   _mon.close();
   _tus.close();
   _wed.close();
   _thur.close();
   _fri.close();
   _image.close();
   _submit.close();
  }
}
