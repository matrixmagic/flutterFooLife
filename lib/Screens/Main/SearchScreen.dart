import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foolife/Dto/SerachRestaurantsDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Repository/SearchRepository.dart';

import 'package:foolife/Widget/my_flutter_app_icons2.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:foolife/Bloc/searsch/SearchBloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';
import 'package:location/location.dart';


import '../../AppTheme.dart';
import 'MainScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 int searchType;
  LatLng _center;
  SerachRestaurantsDto searchResultDto;
  BitmapDescriptor pinLocationIcon;
   Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  var _contro1 = TextEditingController();
  bool restaurantIsBigger;
  int restaurantProductRatio;
  int iRest=0;
  int jProduct=0;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    searchType=1;
    // TODO: implement initState

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent ,statusBarBrightness:  Brightness.light));
    getPos();


  }

void  getPos() async
{
   Location location = new Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

_locationData = await location.getLocation();

pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/map_marker.png');
      _center =  LatLng(_locationData.latitude, _locationData.longitude);
 searchResultDto     =await SearchRepository().serachRestaurants("", -11111.0,-11111.0);
 if(searchResultDto.restaurants.length>searchResultDto.products.length){
   restaurantProductRatio=(searchResultDto.restaurants.length/searchResultDto.products.length).round();
   
  restaurantIsBigger=true;}
 else{
 restaurantProductRatio=(searchResultDto.products.length/searchResultDto.restaurants.length).round();
restaurantIsBigger=false;}

 print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeprinteeeeeeeeeee');
  print(searchResultDto) ;
      var restaurants = searchResultDto.restaurants;
      
restaurants.forEach((element) {
  if(element.latitude!=null && element.longitude!=null)
  _markers.add(
            Marker(
               markerId: MarkerId(element.id.toString()),
               position: LatLng(double.parse( element.latitude.toString()),double.parse( element.longitude.toString())),
              icon: pinLocationIcon 
              ,
              onTap: (){
                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(goToThisRestaurantId: element.id,),
          ),);
              }
            ));
            
  setState(()  {
    
            
  print("add markersssssssssssssssssssssssssssssssssssssssssssssssssssss");
});
   
  
 
   

  print("wakawakaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
});
  }
 
  @override
  Widget build(BuildContext context) {
    _context = context;
    SearchBloc searchBloc = new SearchBloc();
   // searchBloc.changeAll(false);
    //searchBloc.changeFavorite(false);
    //searchBloc.changeRestaurant(true);
    return BlocProvider<SearchBloc>(
      bloc: searchBloc,
      child: SafeArea(
        top: false,
        child: Scaffold(
            body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.025,
                  0.05,
                  0.1,
                  0.5,
                  0.9,
                  0.95,
                  0.99
                ],
                colors: [
                  Colors.black,
                  Colors.grey,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.grey,
                  Colors.black
                ]),
            //image: new DecorationImage(
            //image: new AssetImage('assets/images/gray.jpg'),
            //fit: BoxFit.cover,
            //),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 30, 10, 10),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(

                                autocorrect: true,
                                controller: _contro1,
                                decoration: InputDecoration(
                                  // errorText: snapshot.error,
                                  labelText: 'Search',

                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 23,
                                top: 9,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: AppTheme.primaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () async {

                                    print(_contro1.value.text);
                                    searchResultDto = await SearchRepository().serachRestaurants(_contro1.value.text, _center.latitude, _center.longitude);

 iRest=0;
   jProduct=0;
  
  if(searchResultDto !=null){
  if(searchResultDto.products==null)
restaurantIsBigger=true;
 else if(searchResultDto.restaurants==null)
restaurantIsBigger=false;
else if(searchResultDto.restaurants.length==0)
restaurantIsBigger=false;
else if(searchResultDto.products.length==0)
restaurantIsBigger=true;

  else if(searchResultDto.restaurants.length>searchResultDto.products.length){
   restaurantProductRatio=(searchResultDto.restaurants.length/searchResultDto.products.length).round();
   
  restaurantIsBigger=true;}
 else{
 restaurantProductRatio=(searchResultDto.products.length/searchResultDto.restaurants.length).round();
restaurantIsBigger=false;}
  }
              _markers.clear();
              if(searchResultDto!= null && searchResultDto.restaurants != null && searchResultDto.restaurants.length >0)                            
searchResultDto.restaurants.forEach((element) {
  if(element.latitude!=null && element.longitude!=null)
  _markers.add(
            Marker(
               markerId: MarkerId(element.id.toString()),
               position: LatLng(double.parse( element.latitude.toString()),double.parse( element.longitude.toString())),
              icon: pinLocationIcon 
              ,
              onTap: (){
                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(goToThisRestaurantId: element.id,),
          ),);
              }
            ));
            
  setState(()  {
    
            
  print("add markersssssssssssssssssssssssssssssssssssssssssssssssssssss");
});
  
 
  print("wakawakaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
});
 setState(()  {
    
            
  print("empty");
});
                                    
                                  },
                                ))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              StreamBuilder<Object>(
                                  stream: searchBloc.allStream,
                                  builder: (context, snapshot) {
                                    return GestureDetector(
                                        onTap: () {
                                          searchBloc.changeAll(true);
                                      
                                          searchBloc.changeFavorite(false);
                                          searchBloc.changeRestaurant(false);
                                           setState(() {
                                          searchType=1;
                                        }); 
                                        },
                                        child: Container(
                                            child: Text(
                                          'Alle',
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                              color: snapshot.hasData &&
                                                      snapshot.data
                                                  ? AppTheme.primaryColor
                                                  : Colors.grey
                                                      .withOpacity(0.8)),
                                        )));
                                  }),
                              StreamBuilder<Object>(
                                  stream: searchBloc.restaurantStream,
                                  builder: (context, snapshot) {
                                    return IconButton(
                                        onPressed: () {
                                          searchBloc.changeFavorite(false);
                                          searchBloc.changeAll(false);
                                          searchBloc.changeRestaurant(true);
                                          setState(() {
                                          searchType=3;
                                        }); 
                                        },
                                        icon: Icon(Icons.location_on,
                                            size: 40,
                                            color: snapshot.hasData &&
                                                    snapshot.data
                                                ? AppTheme.primaryColor
                                                : Colors.grey
                                                    .withOpacity(0.8)));
                                  }),
                              StreamBuilder<Object>(
                                  stream: searchBloc.favoriteStream,
                                  builder: (context, snapshot) {
                                    return IconButton(
                                        onPressed: () {
                                          searchBloc.changeRestaurant(false);
                                          searchBloc.changeAll(false);
                                          searchBloc.changeFavorite(true);
                                        setState(() {
                                          searchType=2;
                                        });  
                                        },
                                        icon: Icon(fav.favorite_like__2_,
                                            size: 50,
                                            color: snapshot.hasData &&
                                                    snapshot.data
                                                ? AppTheme.primaryColor
                                                : Colors.grey
                                                    .withOpacity(0.8)));
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                 searchType==3?
                  Expanded(
                    child: _center==null?Container():
                    GoogleMap(
                      myLocationEnabled: true,
                      markers: _markers,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 17.0,
                      ),
                    ),
                  ):Expanded(
                                      child: searchResultDto==null?Container():Container(child:new StaggeredGridView.countBuilder(
  crossAxisCount: 4,
  itemCount: searchResultDto==null?0:(((searchResultDto.products==null)?0: searchResultDto.products.length)+ (searchResultDto.restaurants==null ?0:searchResultDto.restaurants.length)),
  itemBuilder: (BuildContext context, int index) {
    

if( restaurantIsBigger){
print("restaurantIsBigger");

 if( (index+1)%restaurantProductRatio==0){ 
   if(((index+1)/restaurantProductRatio).round()< searchResultDto.products.length)
   jProduct=((index+1)/restaurantProductRatio).round();
   print('llllllllllllllllllllllllllllllllllllllllll    '+jProduct.toString());
    }else{
   if(iRest+1< searchResultDto.restaurants.length)
   iRest++;
 }
}
else{
  print("not is restaurantIsBigger");
   if( (index+1)%restaurantProductRatio==0){
      if(((index+1)/restaurantProductRatio).round()< searchResultDto.restaurants.length)
   iRest=((index+1)/restaurantProductRatio).round();
   print('222222222222222222222222222222222222    '+iRest.toString());
   
 }else{
   print("restaurantIsaaaaaaBigger   "+ searchResultDto.products.length.toString());
   if(jProduct+1< searchResultDto.products.length)
   jProduct++;
 }

}
bool restaurantTurn;
      if((index+1)%restaurantProductRatio==0){
        if(restaurantIsBigger){
          restaurantTurn=false;
        }else{
          restaurantTurn=true;
        }

      }else{

 if(restaurantIsBigger){
          restaurantTurn=true;
        }else{
          restaurantTurn=false;
        }

      }
    bool isVideo= ( (restaurantTurn?searchResultDto.restaurants[iRest].file.extension:searchResultDto.products[jProduct].file.extension)=="mp4"||(restaurantTurn?searchResultDto.restaurants[iRest].file.extension:searchResultDto.products[jProduct].file.extension)=="m3u8")?true:false;


    return  Container(

      

child:isVideo?SearchVideo(url: restaurantTurn?searchResultDto.restaurants[iRest].file.path :searchResultDto.products[jProduct].file.path,): CachedNetworkImage(
                      imageUrl: restaurantTurn?searchResultDto.restaurants[iRest].file.path :searchResultDto.products[jProduct].file.path,
                      
            
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      fit: BoxFit.cover,
                    )
  );},
  staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 2 : 1),
  mainAxisSpacing: 4.0,
  crossAxisSpacing: 4.0,
),),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 5.0,
                right: 5.0,
                child: CustomButtomNavigatior(
                  showDialog: _ParentFunction,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  _ParentFunction() async {
    await _showSelectionDialog(_context);
  }

  BuildContext _context;

  Future<void> _showSelectionDialog(BuildContext context) async {
    print('im clicked hiiiii');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Sign up"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/usersignup');
                  },
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Log in"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/signin');
                  },
                )
              ],
            ),
          ));
        });
  }
}
class SearchVideo extends StatefulWidget {
String url;
int restaurantId;
 
SearchVideo({

this.url ,
this.restaurantId
});

  @override

  _SearchVideoState createState() => _SearchVideoState();
}


class _SearchVideoState extends State<SearchVideo> {
   BetterPlayerController _betterPlayerController;
   int state=0;
  
  @override
  void initState() {
    
      

    
    // TODO: implement initState
    super.initState();

setState(() {
  state=0;
});
    

  }
  void getVideoController() async {
    double _screenWidth = WidgetsBinding.instance.window.physicalSize.width;
    double _screenHeight = WidgetsBinding.instance.window.physicalSize.height;
    var x = await getControllerForVideo(
        widget.url, _screenWidth, _screenHeight);
        
    setState(() {
      _betterPlayerController = x;
    });
  }
  Future<BetterPlayerController> getControllerForVideo(
      String videoUrl, double _screenWidth, double _screenHeight) async {
    

    

      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.NETWORK,
        videoUrl,
        liveStream: true,
      );
      _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true ,
          looping: false,
       
          
        

         aspectRatio: _screenWidth / _screenHeight,
          controlsConfiguration: BetterPlayerControlsConfiguration(
              showControls: false),
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      _betterPlayerController.setVolume(0.0);
      _betterPlayerController.seekTo(Duration( seconds: 1));
      return _betterPlayerController;
    
  }
  @override
  Widget build(BuildContext context) {

    if(state==0){

       return GestureDetector(
         onTap: () async {
          await getVideoController();
          setState(() {
            state =2;
          });

         },
         child: CachedNetworkImage(
                        imageUrl: widget.url.substring(0,widget.url.indexOf(".m3u8"))+".jpg" ,
                        
              
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        fit: BoxFit.cover,
                      ),
       )
  
        ;
    }else
    return 
    Stack(children: <Widget>[
      

    Container( child:   _betterPlayerController !=null 
                      ? GestureDetector(
                        child: Container(
                            child: BetterPlayer(
                              controller: _betterPlayerController,
                              
                            ),
                          ),
                          onTap: (){
                            _betterPlayerController.isPlaying()==true?_betterPlayerController.pause():_betterPlayerController.play();
                          },
                      )
                      : Container(
                       color: Colors.black,
                       child:  Center(child: CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,

                            ),)
                      ),
            
             ),
             Positioned(top:  5, right:  5, child:  IconButton( icon: Icon( Icons.transit_enterexit ) ,color: Colors.white, onPressed: (){
               
                   Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(goToThisRestaurantId: widget.restaurantId),
          ),);


             },),)
             
             
             ]);
  }
}