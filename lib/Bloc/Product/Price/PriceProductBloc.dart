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
  final PublishSubject<int> _allCatergoryPriceSubmit = PublishSubject<int>();
  final BehaviorSubject<String> _allCatergoryPrice = BehaviorSubject<String>();
  final List<BehaviorSubject<ShortModel>> _extraPrice =
      List<BehaviorSubject<ShortModel>>();
  final _allPrice = BehaviorSubject<String>();
  final _allPriceSubmit = PublishSubject<bool>();
  final _sat = BehaviorSubject<int>();
  final _mon = BehaviorSubject<int>();
  final _tus = BehaviorSubject<int>();
  final _son = BehaviorSubject<int>();
  final _wed = BehaviorSubject<int>();
  final _fri = BehaviorSubject<int>();
  final _thur = BehaviorSubject<int>();
  final _categoryId = BehaviorSubject<int>();
  final _from = BehaviorSubject<String>();
  final _to = BehaviorSubject<String>();
  final _amount = BehaviorSubject<String>();
  final _productIds = BehaviorSubject<List<int>>();

  final _timeSubmit = BehaviorSubject<bool>();

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
  Function(int) get changCategoryPriceSubmit =>
      _allCatergoryPriceSubmit.sink.add;

  Function changExtraPrice(ShortModel data, int lstIndex) {
    print("sink says :" + lstIndex.toString() + "  " + data.value);
    _extraPrice[lstIndex].add(data);
  }

  Function(String) get changeAllProductPrice => _allPrice.sink.add;

  Function(bool) get changeAllProductPriceSubmit => _allPriceSubmit.sink.add;
  Function(int) get changeCategoryId => _categoryId.sink.add;
  Function(int) get changeSat => _sat.sink.add;
  Function(int) get changeMon => _mon.sink.add;
  Function(int) get changeTus => _tus.sink.add;
  Function(int) get changeThurt => _thur.sink.add;
  Function(int) get changeWed => _wed.sink.add;
  Function(int) get changeSon => _son.sink.add;
  Function(int) get changefri => _fri.sink.add;
  Function(String) get changeTo => _to.sink.add;
  Function(String) get changefrom => _from.sink.add;
  Function(String) get changeamount => _amount.sink.add;
  Function(bool) get changeTimeSubmit => _timeSubmit.sink.add;
  Function(List<int>) get changeProductIds => _productIds.sink.add;

  ///////////////////stream(output)////////////////////////////////////////

  Stream<String> get allProductPriceStream =>
      _allPrice.stream.transform(valdiator);
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
        var product =
            await ProductRepository().changeContent(data.id, data.value);
        sink.add(data);
      } catch (e) {
        print(e);
        sink.addError(e);
      }
    }));
  }

  Stream<int> get categoryPriceSubmitStream => _allCatergoryPriceSubmit.stream
          .transform(StreamTransformer<int, int>.fromHandlers(
              handleData: (data, sink) async {
        try {
          print("streamm says :  " + data.toString());

          String lastStatement = await _allCatergoryPrice.first;
          var product = await ProductRepository()
              .AllporductCateegoryChangePrice(data, lastStatement);
          sink.add(data);
          sink.close();
        } catch (e) {
          print(e);
          sink.addError(e);
          sink.close();
        }
      }));

  Stream<String> get categoryPriceStream =>
      _allCatergoryPrice.stream.transform(valdiator);
  Stream<int> get categoryIdStream => _categoryId.stream;
  Stream<int> get satStream => _sat.stream;
  Stream<int> get sonStream => _son.stream;
  Stream<int> get monStream => _mon.stream;
  Stream<int> get thurStream => _thur.stream;
  Stream<int> get tusStream => _tus.stream;
  Stream<int> get wedStream => _wed.stream;
  Stream<int> get friStream => _fri.stream;
  Stream<String> get fromStream => _from.stream;
  Stream<String> get toStream => _to.stream;
  Stream<String> get amountStream => _amount.stream.transform(valdiator);
  Stream<List<int>> get productIdsStream => _productIds.stream;

  Stream<bool> get happyTimeSubmitStream =>
      _timeSubmit.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {
        try {
          print('juuuuuuuuuuuuuu');
          String lastFrom = await _from.first;
          String lastTo = await _to.first;
          print('juuuuuuuuuuuuuu1111111111111111');
          String lastAmount = await _amount.first;
          int lastSat = await _sat.first;
          int lastMon = await _mon.first;
          int lastSon = await _son.first;
          int lastThur = await _thur.first;
          print('juuuuuuuuuuuuuu2222222222222222222');
          int lastTus = await _tus.first;
          int lastWed = await _wed.first;
          int lastfri = await _fri.first;
          print('before');
          int lastCategoryID = await _categoryId.first;
          print('after');
          List<int> lastProductIds = await _productIds.first;
          print('juuuuuuuuuuuuuu3333333333333333');
          var resault = await ProductRepository().addHappytime(
              lastFrom,
              lastTo,
              lastAmount,
              lastSon,
              lastMon,
              lastTus,
              lastWed,
              lastThur,
              lastfri,
              lastSat,
              lastProductIds,
              lastCategoryID);
          sink.add(data);
          sink.close();
        } catch (e) {
          print(e);
          sink.addError(e);
          sink.close();
        }
      }));

  Stream<ShortModel> productExtraContentStream(int lstIndex) {
    return _extraProductContent[lstIndex].stream.transform(
        StreamTransformer<ShortModel, ShortModel>.fromHandlers(
            handleData: (data, sink) async {
      try {
        print("streamm says :" + lstIndex.toString() + "  " + data.value);
        var product =
            await ProductRepository().changeExtraContent(data.id, data.value);
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
