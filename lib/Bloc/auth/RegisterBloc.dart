import 'dart:async';
import 'dart:io';

import 'package:foolife/Bloc/AuthValdiator.dart';
import 'package:foolife/Repository/FileRepository.dart';

import 'package:rxdart/rxdart.dart';

import '../basebloc.dart';


class RegisterBloc extends Object with AuthValdiator implements BlocBase {
  final _file = BehaviorSubject<File>();
  final _registerSubmit=BehaviorSubject<bool>();
  Function(File) get changeFile => _file.sink.add;
  Function get registerPressed => _registerSubmit.sink.add;


 Stream<File> get fileStream =>
      _file.stream.transform(StreamTransformer<File, File>.fromHandlers(
          handleData: (data, sink) async {
          sink.add(data);
      }));

  Stream<bool> get registerStream =>
      _registerSubmit.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {
        
        File file = await fileStream.first;
     
        FileRepository fileRepo = new FileRepository();
        var fileUploaded = await fileRepo.UploadFile(file);
        if(fileUploaded !=null)
        sink.add(true);
      }));


  @override
  void dispose() {
    _file.close();
    _registerSubmit.close();
  }
}
