import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/StatisticDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Screens/Restaurant/changeBackground.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';
import 'package:foolife/Widget/dateTimeChart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:foolife/Widget/stories_bar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import '../../AppTheme.dart';
import 'FriendsPage.dart';

class RestaurantDetail extends StatefulWidget {
  final dynamic id;
  RestaurantDto restaurantDto;
  RestaurantDetail({this.id});
  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  RestaurantDto myRestaurant;
  GlobalKey globalKey = GlobalKey();
  List<String> images = [
    'assets/images/Restaurant1.jpg',
    'assets/images/Restaurant2.jpg',
    'assets/images/Restaurant3.jpg',
    'assets/images/Restaurant1.jpg',
    'assets/images/Restaurant2.jpg',
    'assets/images/Restaurant3.jpg',
    'assets/images/Restaurant1.jpg',
    'assets/images/Restaurant2.jpg',
    'assets/images/Restaurant3.jpg',
  ];
  Map<int, bool> appear = new Map<int, bool>();
  int index = 0;
  var date = DateTime(2019, 11, 1);
  String time = '1';
  String chartId = '1';

  addStory(String img) {
    List<String> newList = [];
    newList.add(img);
    newList.addAll(images);

    return newList;
  }

  addBool() {
    Map<int, bool> NewAppear = new Map<int, bool>();
    NewAppear[0] = true;
    for (int i = 0; i < appear.length; i++) {
      NewAppear[i + 1] = appear[i];
    }
    return NewAppear;
  }

  Future<void> _getQrCodeBytes() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      final image = await boundary.toImage(pixelRatio: 10.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
      var _image = MemoryImage(pngBytes);
      final doc = pw.Document();

      final PdfImage imagePdf =
          await pdfImageFromImageProvider(pdf: doc.document, image: _image);

      doc.addPage(pw.Page(build: (pw.Context context) {
        return pw.Container(
            color: PdfColors.white,
            child: pw.Center(
              child: pw.Image(imagePdf, fit: pw.BoxFit.contain),
            )); // Center
      }));
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => doc.save());
    } catch (e) {
      print("excption:" + e);
    }
  }

  Future<void> shareQrCode() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      final image = await boundary.toImage(pixelRatio: 10.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      await Share.file(
          'QrCode', 'QrCode.png', pngBytes.buffer.asUint8List(), 'qrcode/png',
          text: 'This is the image of generated QrCode...');
    } catch (e) {
      print("excption:" + e);
    }
  }

  getRestaurant() async {
    RestaurantDto restaurantDto = await RestaurantRepository().getMyResturant();
    setState(() {
      myRestaurant = restaurantDto;
    });
  }

  printQrCode() async {
    final doc = pw.Document();
    const imageProvider = const AssetImage('assets/images/burger.jpeg');
    final PdfImage image = await pdfImageFromImageProvider(
        pdf: doc.document, image: imageProvider);

    doc.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(image),
      ); // Center
    }));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(doc.save());
    print(output.path);

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  void initState() {
    getRestaurant();

    // TODO: implement initState
    for (int i = 0; i < images.length; i++) {
      setState(() {
        appear[i] = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
        children: <Widget>[
          //title
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: Center(
              child: Text(
                myRestaurant == null ? "" : myRestaurant.name,
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),

          //generate qrcode
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Qrcode generator
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RepaintBoundary(
                              key: this.globalKey,
                              child: QrImage(
                                data: widget.id.toString(),
                                size: 40,
                                backgroundColor: Colors.white24,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                //logo image
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/NoPath.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //sharing and printing qrcode
          Padding(
              padding: const EdgeInsets.only(left: 80, top: 5, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //print QrCode in pdf format
                  InkWell(
                      onTap: () {
                        _getQrCodeBytes();
                      },
                      child: Image.asset(
                          "assets/images/Icon feather-printer.png")),
                  SizedBox(width: 15),

                  //sharing qrcode
                  InkWell(
                      onTap: () async {
                        shareQrCode();
                      },
                      child: Image.asset(
                          "assets/images/Icon feather-share-3.png")),
                ],
              )),

          //spacer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.5),
            child: Container(
              height: 1,
              color: Color.fromRGBO(112, 112, 112, 1.0),
            ),
          ),

          //stories list
          /*storiesBar(
            images: images,
            appear: appear,
          ),*/

          //Allgemeine statistik
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                      offset: Offset(0, 3),
                      blurRadius: 6 // changes position of shadow
                      ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Allgemeine Statistik",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Image.asset("assets/images/Icon open-graph.png")
                ],
              ),
            ),
          ),

          //list of like, favotite, .....
          createListView(),

          //title of graph
          createTitle(),

          //graph
          FutureBuilder<Object>(
              future: RestaurantRepository()
                  .getRestaurantStatistic(chartId, date, time),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<StatisticDto> statistics = snapshot.data;
                  print(statistics.length);
                  List<charts.Series<TimeSeriesSales, DateTime>>
                      _createSampleData() {
                    List<TimeSeriesSales> tableSalesData = [];

                    for (int i = 1; i < statistics.length; i++) {
                      DateTime todayDate = DateTime.parse(statistics[i].date);
                      print(todayDate);
                      tableSalesData.add(
                          new TimeSeriesSales(todayDate, statistics[i].count));
                    }

                    return [
                      new charts.Series<TimeSeriesSales, DateTime>(
                        id: 'Tablet',
                        colorFn: (_, __) =>
                            charts.MaterialPalette.blue.shadeDefault,
                        domainFn: (TimeSeriesSales sales, _) => sales.time,
                        measureFn: (TimeSeriesSales sales, _) => sales.sales,
                        measureUpperBoundFn: (datum, index) => 100,
                        measureLowerBoundFn: (datum, index) => 0,
                        data: tableSalesData,
                      )
                    ];
                  }

                  List<charts.Series> series = _createSampleData();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 4.40),
                      width: 2800,
                      child: DateTimeComboLinePointChart(series),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      height: (MediaQuery.of(context).size.height / 4.35),
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      )));
                } else {
                  return Container(
                    height: (MediaQuery.of(context).size.height / 4.35),
                  );
                }
              }),

          //determine day or month or year
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      time = '1';
                    });
                  },
                  child: Text(
                    "Day",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      time = '2';
                    });
                  },
                  child: Text(
                    "Month",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      time = '3';
                    });
                  },
                  child: Text(
                    "Year",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),

          //buttons
        ],
      ),
      Positioned(
        bottom: MediaQuery.of(context).size.height / 12,
        left: 5.0,
        right: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async {
                 final storage = new FlutterSecureStorage();
        await storage.delete(key: "_roleId");
      await storage.delete(key: "_token");
      await storage.delete(key: "_userId");
               Navigator.of(context)
                            .pushReplacementNamed('/mainscreen');
              },
              child:Icon( Icons.exit_to_app,size:40)
            ),
             Expanded(
              child: Container(),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    images = addStory("assets/images/burger.jpeg");
                    appear = addBool();
                  });
                },
                child: Image.asset(
                  "assets/images/Story Plus.png",
                )),
            SizedBox(
              width: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/mangemenuscreen');
              },
              child: Image.asset(
                "assets/images/Icon simple-producthunt.png",
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FriendPage()),
                  );
                },
                child: Image.asset(
                  "assets/images/Icon awesome-user-friends.png",
                  width: 30,
                  height: 30,
                )),
            SizedBox(
              width: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changeBackground()),
                );
              },
              child: Image.asset(
                "assets/images/Icon feather-settings.png",
                width: 30,
                height: 30,
              ),
            )
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        left: 5.0,
        right: 5.0,
        child: CustomButtomNavigatior(),
      ),
    ]));
  }

  Container createListView() {
    return Container(
      height: 90,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                chartId = '0';
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/Group 144.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("Sesucher"),
                  SizedBox(
                    height: 2,
                  ),
                  Text("268K")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                chartId = '1';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/Group 145.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text("Likes"),
                  Text("235K")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                chartId = '2';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/Group 146.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text("Favorite"),
                  Text("35K")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                chartId = '3';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/Group 147.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text("Kommentare"),
                  Text("25K")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                chartId = '4';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/Group 148.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text("Geteilt"),
                  Text("1M")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                chartId = '5';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/Group 149.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text("Beschwerden"),
                  Text("20")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                chartId = '6';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage(
                              "assets/images/Service Beschwerden.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text("Service Likes"),
                  Text("20")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                chartId = '7';
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image:
                              new AssetImage("assets/images/servicelike.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text("Service Besch"),
                  Text("20")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding createTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.5, vertical: 10),
      child: Row(
        children: <Widget>[
          Spacer(),
          Text("Sesucher"),
          Spacer(),
          Image.asset("assets/images/Icon feather-share-2.png")
        ],
      ),
    );
  }

  /*Stack createGraph(){
    return Stack(
      children: <Widget>[
        new Offstage(
          offstage: index != 0,
          child: new TickerMode(
              enabled: index == 0,
              child: Container(width:100,height:100,color:Colors.red)
          ),
        ),
        new Offstage(
          offstage: index != 1,
          child: new TickerMode(
            enabled: index == 1,
            child: FutureBuilder<Object>(
                future:  RestaurantRepository().getRestrantStatistic('2',date,time),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    List<StatisticDto> statistics = snapshot.data;
                    print(statistics.length);
                    List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {

                      List<TimeSeriesSales> tableSalesData = [];

                      for (int i =1;i<statistics.length;i++){
                        DateTime todayDate = DateTime.parse(statistics[i].date);
                        print(todayDate);
                        tableSalesData.add(new TimeSeriesSales(todayDate, statistics[i].count));
                      }

                      return [
                        new charts.Series<TimeSeriesSales, DateTime>(
                          id: 'Tablet',
                          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                          domainFn: (TimeSeriesSales sales, _) => sales.time,
                          measureFn: (TimeSeriesSales sales, _) => sales.sales,
                          measureUpperBoundFn: (datum, index) => 100,
                          measureLowerBoundFn: (datum, index) => 0,
                          data: tableSalesData,
                        )
                      ];
                    }
                    List<charts.Series> series=_createSampleData();
                    return Container(
                      height: 200,
                      child: DateTimeComboLinePointChart(series),
                    );

                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                }
            ),
          ),
        ),
        new Offstage(
          offstage: index != 2,
          child: new TickerMode(
              enabled: index == 2,
              child: Container(width:100,height:100,color:Colors.green)
          ),
        ),
      ],
    );
  }*/

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
