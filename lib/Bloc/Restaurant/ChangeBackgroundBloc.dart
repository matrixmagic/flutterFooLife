import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foolife/Repository/AuthRepository.dart';
import 'package:foolife/Repository/FileRepository.dart';
import 'package:foolife/Repository/PostRepository.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';

import 'package:rxdart/rxdart.dart';


import '../basebloc.dart';



class ChangeBackgroundBloc extends Object implements BlocBase {
  

final _name = BehaviorSubject<String>();
 
 final _file=BehaviorSubject<File>();
  final _submit=PublishSubject<bool>();


//////////////////////////////sink(input)///////////////////////////////////////
  
  Function(String) get changeName => _name.sink.add;
  
  Function(File) get changeFile => _file.sink.add;
  Function(bool) get changeSubmit => _submit.sink.add;

 
///////////////////////////stream(output)////////////////////////////////////////
 
  
    Stream<String> get nameStream => _name.stream;
 Stream<File> get fileStream => _file.stream;




Stream<bool> get submitStream => _submit.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {

  
          
       File lastFile= await _file.first;
     //  String lastName= await _name.first;
          print ("finis begin file ");
            
         var file =await  FileRepository().UploadFile2(lastFile,1);

         print ("finis uploadd file ");
            if(file!=null){
await RestaurantRepository().changeBackground(file.id);
              print('file add to database ');
          sink.add(true);
          sink.close();
        
//                             SchedulerBinding.instance.addPostFrameCallback((_) {
//                                      // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                    
//  print('gooogooogogogoghhh');
//                           close_it.call();
//                         });
              
        
            }else
          sink.addError("Something went wrong");

          

      }));


     


 
  //   @override
  void dispose() {
 
   _name.close();
  
   _file.close();
   _submit.close();
  }
}
