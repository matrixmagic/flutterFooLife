import 'dart:async';
import 'dart:io';

import 'package:foolife/Repository/ProductRepository.dart';
import 'package:foolife/Utility/ShortModel.dart';

import 'package:rxdart/rxdart.dart';

import '../../basebloc.dart';

import 'PriceProductValdiator.dart';

class PriceProductBloc extends Object
    with PriceProductValdiator
    implements BlocBase {
  final List<BehaviorSubject<ShortModel>> _price =
      List<BehaviorSubject<ShortModel>>();
        final List<BehaviorSubject<ShortModel>> _content =
      List<BehaviorSubject<ShortModel>>();
       final List<BehaviorSubject<ShortModel>> _extraProductContent =
      List<BehaviorSubject<ShortModel>>();
       final PublishSubject<int> _allCatergoryPriceSubmit =
      PublishSubject<int>();
       final BehaviorSubject<String> _allCatergoryPrice =
      BehaviorSubject<String>();
  final List<BehaviorSubject<ShortModel>> _extraPrice =
      List<BehaviorSubject<ShortModel>>();
  final _allPrice = BehaviorSubject<String>();
  final _allPriceSubmit = PublishSubject<bool>();

  RequestNewPriceSubject() {
    _price.add(new BehaviorSubject<ShortModel>());
  }


  

 RequestNewContentSubject() {
    _content.add(new BehaviorSubject<ShortModel>());
  }
   RequestNewextraProductContentSubject() {
    _extraProductContent.add(new BehaviorSubject<ShortModel>());
  }
  RequestNewExtraPriceSubject() {
    _extraPrice.add(new BehaviorSubject<ShortModel>());
  }

////
//////////////////////////////sink(input)///////////////////////////////////////
  Function changPrice(ShortModel data, int lstIndex) {
    print("sink says :" + lstIndex.toString() + "  " + data.value);
    _price[lstIndex].add(data);
  }
    Function changContent(ShortModel data, int lstIndex) {
    print("sink says :" + lstIndex.toString() + "  " + data.value);
    _content[lstIndex].add(data);
  }
  Function changExtraProductContent(ShortModel data, int lstIndex) {
    print("sink says :" + lstIndex.toString() + "  " + data.value);
    _extraProductContent[lstIndex].add(data);
  }

  Function(String) get changCategoryPrice => _allCatergoryPrice.sink.add;
  Function(int) get changCategoryPriceSubmit => _allCatergoryPriceSubmit.sink.add;


  Function changExtraPrice(ShortModel data, int lstIndex) {
    print("sink says :" + lstIndex.toString() + "  " + data.value);
    _extraPrice[lstIndex].add(data);
  }

  Function(String) get changeAllProductPrice => _allPrice.sink.add;

  Function(bool) get changeAllProductPriceSubmit => _allPriceSubmit.sink.add;

  ///////////////////stream(output)////////////////////////////////////////

  Stream<String> get allProductPriceStream => _allPrice.stream.transform(valdiator);
  Stream<ShortModel> productPrice(int lstIndex) {
   
    return _price[lstIndex].stream.transform(
        StreamTransformer<ShortModel, ShortModel>.fromHandlers(
            handleData: (data, sink) async {
      try {
        print("streamm says :" + lstIndex.toString() + "  " + data.value);
        var product = await ProductRepository()
            .changePrice(data.id, double.parse(data.value));
        sink.add(data);
      } catch (e) {
        print(e);
        sink.addError(e);
      }
    }));
  }

   Stream<ShortModel> productContentStream(int lstIndex) {
   
    return _content[lstIndex].stream.transform(
        StreamTransformer<ShortModel, ShortModel>.fromHandlers(
            handleData: (data, sink) async {
      try {
        print("streamm says :" + lstIndex.toString() + "  " + data.value);
        var product = await ProductRepository()
            .changeContent(data.id,data.value);
        sink.add(data);
      } catch (e) {
        print(e);
        sink.addError(e);
      }
    }));
  }

 Stream<int> get categoryPriceSubmitStream => _allCatergoryPriceSubmit.stream.transform(   StreamTransformer<int, int>.fromHandlers(
            handleData: (data, sink) async {
      try {
        print("streamm says :  " + data.toString());

        String lastStatement =await  _allCatergoryPrice.first;
        var product = await ProductRepository()
            .AllporductCateegoryChangePrice(data,lastStatement);
        sink.add(data);
         sink.close();
      } catch (e) {
        print(e);
        sink.addError(e);
         sink.close();
      }
    }));
  


 Stream<String> get categoryPriceStream => _allCatergoryPrice.stream.transform(valdiator);



 Stream<ShortModel> productExtraContentStream(int lstIndex) {
  
    return _extraProductContent[lstIndex].stream.transform(
        StreamTransformer<ShortModel, ShortModel>.fromHandlers(
            handleData: (data, sink) async {
      try {
        print("streamm says :" + lstIndex.toString() + "  " + data.value);
        var product = await ProductRepository()
            .changeExtraContent(data.id,data.value);
        sink.add(data);
      } catch (e) {
        print(e);
        sink.addError(e);
      }
    }));
  }
  Stream<ShortModel> extraProductPrice(int lstIndex) {
    return _extraPrice[lstIndex].stream.transform(
        StreamTransformer<ShortModel, ShortModel>.fromHandlers(
            handleData: (data, sink) async {
      try {
        print("streamm says :" + lstIndex.toString() + "  " + data.value);
        var product = await ProductRepository()
            .changeExtraPrice(data.id, double.parse(data.value));
        sink.add(data);
      } catch (e) {
        print(e);
        sink.addError(e);
      }
    }));
  }

  Stream<bool> get allProductPriceSubmitStream => _allPriceSubmit.stream
          .transform(StreamTransformer<bool, bool>.fromHandlers(
              handleData: (data, sink) async {
        try {
          String lastAllProductProceState = await _allPrice.first;

          var res = await ProductRepository()
              .ChangeporductsAllPrice(lastAllProductProceState);
          if (res == true) {
            print("bloc say change all price successful");
            sink.add(true);
            sink.close();
          } else {
            print("product false error ");
            sink.add(false);
              sink.close();
          }
        } catch (e) {
          print(e);
          print(" bloc say change all price with error ");
          sink.add(false);
            sink.close();
        }
      }));

  @override
  void dispose() {
    _allPriceSubmit.close();
    _allCatergoryPriceSubmit.close();
  
  }
}
