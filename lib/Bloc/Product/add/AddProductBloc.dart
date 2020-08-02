import 'dart:async';
import 'dart:io';




import 'package:foolife/Dto/FileDto.dart';
import 'package:foolife/Repository/FileRepository.dart';
import 'package:foolife/Repository/ProductRepository.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../../basebloc.dart';

import 'AddProductValdiator.dart';


class AddProductBloc extends Object with AddProductValdiator implements BlocBase {
  
  final _productName=BehaviorSubject<String>(); 
  final _price=BehaviorSubject<String>();
  final _file=BehaviorSubject<File>();
  final _categoryId=BehaviorSubject<dynamic>();
  final _addPressed=BehaviorSubject<bool>();
  final _details=BehaviorSubject<dynamic>();

  
////
//////////////////////////////sink(input)///////////////////////////////////////
  Function(File) get changeFile => _file.sink.add;
  Function(String) get changeProductName => _productName.sink.add;
  Function(String) get changePrice => _price.sink.add;
   Function(dynamic) get changeCategoryId => _categoryId.sink.add;
   Function(bool) get addRegister => _addPressed.sink.add;
   Function(dynamic) get chageDetails => _details.sink.add;
///////////////////////////stream(output)////////////////////////////////////////
 Stream<String> get productNameStream => _productName.stream.transform(valdiator);
 Stream<String> get priceStream => _price.stream.transform(valdiator);
 Stream<File> get fileStream => _file.stream;
 Stream<dynamic> get categoryIdStream => _categoryId.stream;
 Stream<dynamic> get detailsStream => _details.stream;


Stream<bool> get submitRegisterStream => _addPressed.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {

  try{
            String lastProductName=await  _productName.first;
           // double lastPrice =double.parse(  await _price.first);
            File lastfile = await   _file.first;
            print('before lastCategory');
            dynamic lastCategoryId= await _categoryId.first;
             print('before lastDetalis');
            dynamic lastDetalis =await _details.first;
             print(lastDetalis);
            print("before file");
         var file=   await FileRepository().UploadFile2(lastfile, 1);
             print("after file");
         var product =await  ProductRepository().add(lastProductName,null ,file.id, lastCategoryId,lastDetalis);
          if(product !=null){
            print("finish add product");
            sink.add(true);
          }else{
             print("product nullll ");
           sink.add(false);
          }
  }catch( e){
    print(e);
print("finish add with error product");
    sink.add(false);
  }
      }));


  

  /////////////////////////////////////////////////////////
  Stream<bool> get addValid =>
     Rx.combineLatest3(productNameStream ,priceStream, fileStream,(a, b,c,) => true);    


      


 
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
 
    _productName.close();
    _price.close();
    _file.close();
    _categoryId.close();

  }
}
