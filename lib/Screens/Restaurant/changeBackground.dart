import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Bloc/Product/add/AddProductBloc.dart';
import 'package:foolife/Bloc/Restaurant/ChangeBackgroundBloc.dart';
import 'package:foolife/Screens/Restaurant/TrimmerView.dart';
import 'package:foolife/Screens/Restaurant/VedioProduct.dart';
import 'package:foolife/Screens/Restaurant/addProductDetails.dart';
import 'package:foolife/Screens/Welcome/UserSignup.dart';
import 'package:multi_media_picker/multi_media_picker.dart';

import 'package:video_trimmer/video_trimmer.dart';


class changeBackground extends StatelessWidget {
 


ChangeBackgroundBloc changeBackgroundBloc =new ChangeBackgroundBloc();
 final Trimmer _trimmer = Trimmer();
  @override
  Widget build(BuildContext context) {




    return Scaffold(
          body: Stack(
        children: <Widget>[
          StreamBuilder<Object>(
            stream: changeBackgroundBloc.fileStream,
            builder: (context, snapshot) {

              if(snapshot.hasData ){
                        
             File file=     snapshot.data as File;
             print("saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
              print(file.path);

        String ext= file.path.substring(file.path.lastIndexOf("."));
         print(ext);
          if(ext !=".mp4"){
             
  
                return Container(
                height: MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage( 
                    
                    image:  FileImage(snapshot.data),
                    fit: BoxFit.fitHeight,
                    
                  ),
                ));

          }
          else{



            
         return  VideoProductView(file);


          }
              }else{
              return Container(
                
                height: MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage( 
                    image: AssetImage("assets/images/Restaurant1.jpg",),
                    fit: BoxFit.fitHeight,
                    
                  ),
                ),
              
 );
              }
            }
          ),
      //        Padding( 
      //         padding : EdgeInsets.fromLTRB(10.0, 30, 30, 24),
      // child: TextField(
             
      //         autocorrect: true,
      //         decoration: InputDecoration(
      //           icon: Icon(Icons.verified_user,
      //               color: true
      //                   ? AppTheme.redText
      //                   : AppTheme.primaryColor),
               
      //           labelText: 'Email',
      //           hintText: 'Email adress',
      //           hintStyle: TextStyle(color: Colors.grey),
      //           filled: true,
      //           fillColor: Colors.white70,
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(12.0)),
      //             borderSide:
      //                 BorderSide(color: AppTheme.primaryColor, width: 2),
      //           ),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //             borderSide: BorderSide(
      //               color: AppTheme.primaryColor,
      //             ),
      //           ),
      //         ),
      //       )
        
    
          
      //        ),
         
          Positioned(child: Padding( 
              padding : EdgeInsets.fromLTRB(200, 20, 0, 0) ,
               child: StreamBuilder(
                // stream: addProductBloc.productNameStream,
                 builder: (context, snapshot) {
                   return TextField( style: TextStyle(color: Colors.white),
                //  onChanged:addProductBloc.changeProductName,
                     decoration: InputDecoration(
                   
                   labelStyle:
                       TextStyle(color: Colors.white, fontSize: 16.0),
                    labelText: 'restaurant name',
              
                    //hintStyle: TextStyle(color: Colors.white),
                    
                    filled: true,
                    
                   )
                     
                     
                   );
                 }
               ), )),
          StreamBuilder<Object>(
            stream: changeBackgroundBloc.fileStream,
            builder: (context, snapshot) {

              if(snapshot.hasData)
              return Center(child: Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[ 
                  Text("you have select a new background" ,style: TextStyle(fontSize: 20,color: Colors.white ),),
                  IconButton( icon: Icon( Icons.autorenew, size: 40,color:  AppTheme.notWhite,), onPressed: (){ _settingModalBottomSheet(context,changeBackgroundBloc);},)],),
              ));
              else{
                   return Center(child: Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[ 
                  Text("add a background" ,style: TextStyle(fontSize: 20,color: Colors.white ),),
                  IconButton( icon: Icon( Icons.add, size: 40,color:  AppTheme.notWhite,), onPressed: (){ _settingModalBottomSheet(context,changeBackgroundBloc);},)],),
              ));

              }
            }
          ),
           StreamBuilder(
                stream: changeBackgroundBloc.submitStream,
                builder: (context, snapshot2) {
                    print(snapshot2);
                  if (snapshot2.hasData) {
                    print(snapshot2);
                    if (snapshot2.data == true) {
                  
                        print("Navigator goo go");
                        
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                                     // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                      
                           Navigator.pushNamed(context, '/restaurantDetail');
                          
                             
                        });
                      }
                     else if(snapshot2.data==false) {
                   
                          Navigator.of(context).pop();
                      print("submit error");
                         return Text("eeeeee", style: AppTheme.error);
                     }
                     // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                   
                    }
                  
                  return Container();
                },
              ),


          Positioned(
            right: 20,
            bottom: 40,
            child: Column( 
            children: <Widget>[
                     
              IconButton(icon:Icon( Icons.check_circle,size: 30, color: Colors.green, ),onPressed: (){
                print("addd product");
                  Dialogs.showLoadingDialog(context);
                changeBackgroundBloc.changeSubmit(true);

              },), 
              IconButton(icon:Icon( Icons.cancel,size: 30, color: Colors.red, ),onPressed: (){

  Navigator.of(context).pop();
              },), ],
              
          )
          
          
          )
        ],
      ),
    );
  }



 void _settingModalBottomSheet(context,ChangeBackgroundBloc changeBackgroundBloc){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
new ListTile(
            leading: new Icon(Icons.image),
            title: new Text('Photo'),
            onTap: () async  {

var  picture = await MultiMediaPicker.pickImages(
                        source: ImageSource.gallery);
                    if(picture!=null && picture.length>0)    
                   changeBackgroundBloc.changeFile(picture[0]);
                    Navigator.of(bc).pop();

            }          
          ),
          new ListTile(
            leading: new Icon(Icons.videocam),
            title: new Text('Video'),
            onTap: ()  async {
               var video = await MultiMediaPicker.pickVideo(
                      source: ImageSource.gallery);

                       if (video != null) {
             var videoo =  await _trimmer.loadVideo(videoFile: video);
                                  
                 Navigator.of(bc)
                    .push(MaterialPageRoute(builder: (context) {
                  return TrimmerView(_trimmer ,changeBackgroundBloc:  changeBackgroundBloc,video:  video);
                }));
                  //    addProductBloc.changeFile(video);
                print(video.path);
                    //   Navigator.of(bc).pop();
                       }
            },          
          ),
            ],
          ),
          );
      }
    );
}
  
}