import 'package:flutter/material.dart';
import 'package:foolife/Bloc/Product/add/AddProductBloc.dart';
import 'package:foolife/Bloc/provider.dart';

class addProductDetails extends StatelessWidget {
   AddProductBloc addProductBloc;
   addProductDetails({this.addProductBloc});
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height/27);
     int rosnum =  (MediaQuery.of(context).size.height/27).floor();
    return Scaffold(
          body: SingleChildScrollView(
                      child: Column(
        children: <Widget>[
            Container(
              height: 60,
              child: Center(child: Text("Information of your product")),
              
              decoration: BoxDecoration(border: Border.all(width: 1)),
            ),
          
                       Container(decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Expanded(child:  TextFormField(
                  onChanged: addProductBloc.chageDetails,
                                     maxLines: rosnum ,
                                      keyboardType: TextInputType.multiline,
                                      maxLength: 1000,


                                    ),),
              ),

               Container(
              height: 60,
              child: Row( 
                mainAxisAlignment:  MainAxisAlignment.end,
                children: <Widget>[IconButton(onPressed:(){

                   Navigator.of(context).pop();
                } ,icon:  Icon( Icons.check_circle ,color:  Colors.green, size :35 ),

                )],
              ),
              
              decoration: BoxDecoration(border: Border.all(width: 1)),
            ),
          
        ],
      ),
          ),
    );
  }
}