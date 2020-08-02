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
  final List<BehaviorSubject<ShortModel>> _extraPrice =
      List<BehaviorSubject<ShortModel>>();
  final _allPrice = BehaviorSubject<String>();
  final _allPriceSubmit = PublishSubject<bool>();

  RequestNewPriceSubject() {
    _price.add(new BehaviorSubject<ShortModel>());
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

  Function changExtraPrice(ShortModel data, int lstIndex) {
    print("sink says :" + lstIndex.toString() + "  " + data.value);
    _extraPrice[lstIndex].add(data);
  }

  Function(String) get changeAllProductPrice => _allPrice.sink.add;

  Function(bool) get changeAllProductPriceSubmit => _allPriceSubmit.sink.add;

  ///////////////////stream(output)////////////////////////////////////////

  Stream<String> get allProductPriceStream => _allPrice.stream.transform(valdiator);
  Stream<ShortModel> productPrice(int lstIndex) {
    print(lstIndex);
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
  }
}
