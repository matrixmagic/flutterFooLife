import 'dart:math';

import 'package:better_player/better_player.dart';

import '../basebloc.dart';

class   VideoBloc  
{

 List <BetterPlayerController> betterPlayerController= new List <BetterPlayerController>(); 


 void  addVideo(BetterPlayerController bpc)
{
 betterPlayerController.add(bpc) ;
 print("dddddddddddddddd add"+betterPlayerController.length.toString() );
}


 void disposeAllVideos() async
{
print("dddddddddddddddd delete"+betterPlayerController.length.toString() );
  await betterPlayerController.forEach((element) async {
    if(element!= null)
    {
      try{
      if(await element.isPlaying()==true ){
    element.setVolume(0);
    element.pause();
    }}
    catch(e){
    print(e);}
    }
  });
  betterPlayerController.clear();
}
 void  disposeAllVideosleave () async
{
  print("dddddddddddddddd delete"+betterPlayerController.length.toString() );
for(int i=0;i<betterPlayerController.length-1;i++)
  {try{
    if(betterPlayerController[i]== null)continue;
    if(await betterPlayerController[i].isPlaying()==true){
    betterPlayerController[i].setVolume(0);
    betterPlayerController[i].pause();
    
    }}
    catch(e){
    print(e);}
    //betterPlayerController[i].dispose();
   // betterPlayerController.removeAt(i);
  };

}






}