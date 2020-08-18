import 'dart:async';

import 'package:foolife/Repository/AuthRepository.dart';

import 'package:rxdart/rxdart.dart';

import 'basebloc.dart';

class TopBarBloc extends Object implements BlocBase {
  final _first = BehaviorSubject<bool>();
  final _second = BehaviorSubject<bool>();
  final _third = BehaviorSubject<bool>();
  final _fourth = BehaviorSubject<bool>();
  final _click = BehaviorSubject<bool>();

//////

//////////////////////////////sink(input)///////////////////////////////////////

  Function(bool) get changeFirst => _first.sink.add;
  Function(bool) get changeSecond => _second.sink.add;
  Function(bool) get changeThird => _third.sink.add;
  Function(bool) get changeFourth => _fourth.sink.add;
  Function(bool) get changeClick => _click.sink.add;

///////////////////////////stream(output)////////////////////////////////////////
  Stream<bool> get firstStream => _first.stream;

  Stream<bool> get secondStream => _second.stream;
  Stream<bool> get thirdStream => _third.stream;
  Stream<bool> get fourthtStream => _fourth.stream;

  Stream<bool> get onClick =>
      _click.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {
        bool lastfirst = await _first.first;
        bool lastsecond = await _second.first;
        bool lastthird = await _third.first;
        bool lastfourth = await _fourth.first;

        /*    var user =await  AuthRepository().register(la, lastpassword, lastConfirmPassword, lastRole,lastPhoneNumber);
            if(user!=null){

              print(user);
          sink.add(true);

            }else
          sink.addError("Something went wrong");
*/
      }));

  /////////////////////////////////////////////////////////

  @override
  void dispose() {
    _first.close();
    _click.close();
    _second.close();
    _third.close();
    _fourth.close();
  }
}
