import 'dart:async';

import 'package:foolife/Repository/AuthRepository.dart';

import 'package:rxdart/rxdart.dart';

import '../basebloc.dart';



class SearchBloc extends Object  implements BlocBase {
  
  final _search=BehaviorSubject<String>();
  final _click=BehaviorSubject<bool>();
  final _favorite=BehaviorSubject<bool>();
  final _restaurant=BehaviorSubject<bool>();
  final _all=BehaviorSubject<bool>();
  
  

//////

//////////////////////////////sink(input)///////////////////////////////////////
  
  Function(String) get changeSearch => _search.sink.add;
  Function(bool) get changeClick => _click.sink.add;
  Function(bool) get changeFavorite => _favorite.sink.add;
  Function(bool) get changeRestaurant => _restaurant.sink.add;
  Function(bool) get changeAll => _all.sink.add;
 
///////////////////////////stream(output)////////////////////////////////////////
 Stream<String> get searchStream =>_search.stream;

 Stream<bool> get favoriteStream => _favorite.stream;
  Stream<bool> get allStream => _all.stream;
Stream<bool> get restaurantStream => _restaurant.stream;






Stream<bool> get onClick => _click.stream.transform(StreamTransformer<bool, bool>.fromHandlers(
          handleData: (data, sink) async {

  
            String lastsearch=await  _search.first;
            bool lastfavorite= await _favorite.first;
            bool lastrestaurant = await   _restaurant.first;
            bool lastall= await _all.first; 
           
           
            
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

 
    _search.close();
    _click.close();
    _favorite.close();
    _restaurant.close();
    _all.close();
  }
}
