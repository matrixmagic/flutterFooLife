import 'dart:async';

import 'package:foolife/Bloc/AuthValdiator.dart';
import 'package:foolife/Repository/AuthRepository.dart';
import 'package:rxdart/rxdart.dart';

import 'basebloc.dart';

class AuthBloc extends Object with AuthValdiator implements BlocBase {
  final _Email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _Action = BehaviorSubject();
  final _login = BehaviorSubject<bool>();

  Function(String) get changeEmail => _Email.sink.add;
  Function(String) get changepass => _password.sink.add;
  Function get loginpress => _login.sink.add;
  //Function(String) get changepass => _password.sink.add;
  Stream<bool> get loginstream =>
      _login.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {
        String mail = await Emailstream.first;
        String pass = await passstream.first;

        AuthRepository auth = new AuthRepository();
        var res = await auth.login(mail, pass);
        print(res);
        sink.add(res);
      }));

  Stream<String> get Emailstream => _Email.stream.transform(validateEmail);
  Stream<String> get passstream => _password.stream.transform(validatepass);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(Emailstream, passstream, (a, b) => true);

  @override
  void dispose() {
    _Email.close();
    _password.close();
  }
}
