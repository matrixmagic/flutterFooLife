import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Bloc/Product/Price/PriceProductBloc.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Repository/ProductRepository.dart';
import 'package:foolife/Utility/ShortModel.dart';

class PorductPrice extends StatefulWidget {
  @override
  _PorductPriceState createState() => _PorductPriceState();
}

class _PorductPriceState extends State<PorductPrice> {
  static var _allPricecontroller = TextEditingController();
  List<CategoryDto> categories;

  Future<List<CategoryDto>> _fetchsCategory() async {
    var x = await ProductRepository().getAllCatetoriesAndProucts();
    setState(() {
      categories = x;
    });

    return categories;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchsCategory();
  }

  @override
  Widget build(BuildContext context) {
    PriceProductBloc priceProductBloc = new PriceProductBloc();

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Auf alle Artiklen bewirken",
                style: AppTheme.body2,
              ),
              Container(
                height: (MediaQuery.of(context).size.height / 24),
                width: (MediaQuery.of(context).size.height / 5.5),
                child: StreamBuilder<Object>(
                    stream: priceProductBloc.allProductPriceStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _allPricecontroller,
                        onChanged: priceProductBloc.changeAllProductPrice,
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          errorText: snapshot.error,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
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
                      );
                    }),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: AppTheme.primaryColor,
                ),
                onPressed: () {
                  priceProductBloc.changeAllProductPriceSubmit(true);
                  _allPricecontroller.clear();
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          StreamBuilder(
              stream: priceProductBloc.allProductPriceSubmitStream,
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    upDateList();
                  }
                }
                return Container();
              }),
          Expanded(
            child: ListView.builder(
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return PriceItem(
                      categories: categories,
                      index: index,
                      updateList: this.upDateList);
                }),
          )
        ],
      ),
    );
  }

  upDateList() async {
    print("call upDateList");
    await _fetchsCategory();
  }
}

class PriceItem extends StatefulWidget {
  int index;

  Function updateList;
  PriceItem({
    this.index,
    Key key,
    this.categories,
    this.updateList,
  }) : super(key: key);

  final List<CategoryDto> categories;

  @override
  _PriceItemState createState() => _PriceItemState();
}

List<Widget> productincategory;

class _PriceItemState extends State<PriceItem> with TickerProviderStateMixin {
  bool radiobool = false;
  HashMap map = new HashMap<int, int>();
  HashMap mapEx = new HashMap<int, int>();
  HashMap categoryMap = new HashMap<int, int>();

  bool mo = false;
  bool sa = false;
  bool so = false;
  bool mi = false;
  bool fr = false;
  bool di = false;
  bool don = false;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    var _priceCategorycontroller = TextEditingController();
    productincategory = new List();
    PriceProductBloc priceProductBloc = new PriceProductBloc();
    int i = 0, j = 0;

    widget.categories[widget.index].products.forEach((pro) {
      priceProductBloc.RequestNewContentSubject();
      priceProductBloc.RequestNewPriceSubject();

      if (!map.containsKey(pro.id)) {
        map[pro.id] = i;
      }

      productincategory.add(
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          Container(width: 65, child: Text(pro.name)),
          Container(
            height: (MediaQuery.of(context).size.height / 24),
            width: (MediaQuery.of(context).size.height / 5),
            child: StreamBuilder(
                stream: priceProductBloc.productContentStream(map[pro.id]),
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: (value) {
                      ShortModel short = new ShortModel();
                      short.id = pro.id;
                      short.value = value;
                      priceProductBloc.changContent(short, map[pro.id]);
                    },
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                      hintText: pro.content,
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: AppTheme.primaryColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            height: (MediaQuery.of(context).size.height / 24),
            width: (MediaQuery.of(context).size.height / 9),
            child: StreamBuilder(
                stream: priceProductBloc.productPrice(map[pro.id]),
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {
                      ShortModel short = new ShortModel();
                      short.id = pro.id;
                      short.value = value;

                      print(value);
                      priceProductBloc.changPrice(short, map[pro.id]);
                    },
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                      hintText: pro.price,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: AppTheme.primaryColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              print('icon si  pressed');
              var extraproduct = await ProductRepository().addExtra(pro.id);
              setState(() {
                mapEx.clear();
                widget.updateList.call();
              });
            },
          ),
          Radio(
            groupValue: true,
            hoverColor: Colors.blue,
            activeColor: AppTheme.primaryColor,
            focusColor: Colors.blue,
            value: true,
            onChanged: (bool x) {
              setState(() {
                radiobool = !radiobool;
              });
            },
          ),
          /*SizedBox(
            width: (MediaQuery.of(context).size.height / 20),
          )*/
        ]),
      );

      widget.categories[widget.index].products[i].productExtra.forEach((proEx) {
        print(proEx.name);
        priceProductBloc.RequestNewExtraPriceSubject();
        priceProductBloc.RequestNewextraProductContentSubject();
        if (!mapEx.containsKey(proEx.id)) {
          mapEx[proEx.id] = j;
        }
        productincategory.add(
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
              Widget>[
            Container(width: 65, child: Text("")),
            Container(
              height: (MediaQuery.of(context).size.height / 24),
              width: (MediaQuery.of(context).size.height / 5),
              child: StreamBuilder(
                  stream: priceProductBloc
                      .productExtraContentStream(mapEx[proEx.id]),
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: (value) {
                        ShortModel short = ShortModel();
                        short.id = proEx.id;
                        short.value = value;
                        priceProductBloc.changExtraProductContent(
                            short, mapEx[proEx.id]);
                      },
                      autocorrect: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        hintText: proEx.name,
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: AppTheme.primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: (MediaQuery.of(context).size.height / 24),
                width: (MediaQuery.of(context).size.height / 5),
                child: StreamBuilder(
                    stream: priceProductBloc.extraProductPrice(mapEx[proEx.id]),
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.number,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {
                          var short = ShortModel();
                          short.id = proEx.id;
                          short.value = value;
                          priceProductBloc.changExtraPrice(
                              short, mapEx[proEx.id]);
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          hintText: proEx.price,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
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
                      );
                    }),
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.height / 100),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.height / 100),
            )
          ]),
        );

        j++;
      });

      i++;
    });

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //
                Container(
                  width: 100,
                  child: Column(children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(Icons.folder_open),
                    ),
                    Text(widget.categories[widget.index].name)
                  ]),
                ),
                // SizedBox(width: 20,),

                Container(
                  height: (MediaQuery.of(context).size.height / 24),
                  width: (MediaQuery.of(context).size.height / 4),
                  child: StreamBuilder(
                      stream: priceProductBloc.categoryPriceStream,
                      builder: (context, snapshot) {
                        return TextField(
                          onChanged: (value) =>
                              priceProductBloc.changCategoryPrice(value),
                          autocorrect: true,
                          controller: _priceCategorycontroller,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.all(1.0),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            errorText: snapshot.error,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
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
                        );
                      }),
                ),

                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    priceProductBloc.changCategoryPriceSubmit(
                        widget.categories[widget.index].id);
                    _priceCategorycontroller.clear();
                  },
                ),
                StreamBuilder(
                    stream: priceProductBloc.categoryPriceSubmitStream,
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        widget.updateList.call();
                        print('call parent  ');
                      }
                      return Container();
                    }),
              ],
            ),
            AnimatedSwitcher(
              child: isVisible
                  ? Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("Mo"),
                                Checkbox(
                                  value: mo,
                                  onChanged: (value) {
                                    setState(() {
                                      mo = !mo;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("Di"),
                                Checkbox(
                                  value: di,
                                  onChanged: (value) {
                                    setState(() {
                                      di = !di;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("Mi"),
                                Checkbox(
                                  value: mi,
                                  onChanged: (value) {
                                    setState(() {
                                      mi = !mi;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("Do"),
                                Checkbox(
                                  value: don,
                                  onChanged: (value) {
                                    setState(() {
                                      don = !don;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("Fr"),
                                Checkbox(
                                  value: fr,
                                  onChanged: (value) {
                                    setState(() {
                                      fr = !fr;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("Sa"),
                                Checkbox(
                                  value: sa,
                                  onChanged: (value) {
                                    setState(() {
                                      sa = !sa;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("So"),
                                Checkbox(
                                  value: so,
                                  onChanged: (value) {
                                    setState(() {
                                      so = !so;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: 40),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:
                                    (MediaQuery.of(context).size.height / 24),
                                width:
                                    (MediaQuery.of(context).size.height / 10),
                                child: TextField(
                                  // onChanged: resturantRegistertionBloc.changeResturantName,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    // contentPadding: EdgeInsets.all(5.0),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor,
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text('von'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:
                                    (MediaQuery.of(context).size.height / 24),
                                width:
                                    (MediaQuery.of(context).size.height / 10),
                                child: TextField(
                                  // onChanged: resturantRegistertionBloc.changeResturantName,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    //contentPadding: EdgeInsets.all(5.0),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor,
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text('bis'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:
                                    (MediaQuery.of(context).size.height / 24),
                                width:
                                    (MediaQuery.of(context).size.height / 10),
                                child: TextField(
                                  // onChanged: resturantRegistertionBloc.changeResturantName,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5.0),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor,
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Radio(
                              groupValue: true,
                              hoverColor: Colors.blue,
                              activeColor: AppTheme.primaryColor,
                              focusColor: Colors.blue,
                              value: true,
                              onChanged: (bool x) {
                                setState(() {
                                  radiobool = !radiobool;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(),
                            Text('beschreibung'),
                            Text('preis'),
                            SizedBox(),
                            SizedBox(),
                          ],
                        ),
                        Column(
                          children: productincategory,
                        ),
                      ],
                    )
                  : SizedBox(),
              duration: Duration(microseconds: 100),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
