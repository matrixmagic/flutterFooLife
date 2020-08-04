import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Bloc/Product/add/AddProductBloc.dart';
import 'package:foolife/Screens/Restaurant/AddProduct.dart';
import 'package:foolife/Screens/Welcome/UserSignup.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Models/FileorDir.dart';
import 'package:foolife/Repository/CategoryRepository.dart';
import 'package:foolife/Repository/ProductRepository.dart';
import 'package:foolife/Widget/custom_alert.dart';
import 'package:foolife/Widget/dir_item.dart';
import 'package:foolife/Widget/file_item.dart';
import 'package:foolife/Widget/path_bar.dart';
import 'package:foolife/Widget/sort_sheet.dart';
/*import 'package:image_picker/image_picker.dart';*/

class ExplorerScreen extends StatefulWidget {
  final String title;
  final String path;

  ExplorerScreen({
    Key key,
    @required this.title,
    @required this.path,
  }) : super(key: key);

  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen>
    with WidgetsBindingObserver {
  String path;
  List<String> paths = List();
  List<FileorDir> enterPath = List();

  List<FileorDir> categoriesList = List();
  List<FileorDir> productsList = List();

  bool showHidden = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getFiles();
    }
  }
dynamic parentCategoryId = null;
  getFiles() async {
    
    print(parentCategoryId);
    if (enterPath.length > 0) parentCategoryId = enterPath.last.id;
    else{
      parentCategoryId=null;
    }
    print(parentCategoryId);
    List<CategoryDto> categories =
        await CategoryRepository().getAllCatetoriesInSide(parentCategoryId);
    List<ProductDto> products =
        await ProductRepository().getProductsInSide(parentCategoryId);

    var categories1 = new List<FileorDir>();
    if (categories != null) {
      if (categories.length > 0)
        categories.forEach((element) {
          categories1.add(FileorDir(
              path: element.name,
              isDirectory: true,
              parentCategoryId: element.parentCategoryId,
              id: element.id));
        });
    }

    if (products != null) {
      if (products.length > 0)
        products.forEach((element) {
          categories1.add(FileorDir(
              path: element.name,
              isDirectory: false,
              price: element.price,
              extention:element.file.extension,
              imageURl: element.file.path,
              id: element.id));
        });
    }
 
    var productList1 = new List<FileorDir>();
    if (products != null) {
      if (products.length > 0)
        products.forEach((element) {
          productList1.add(FileorDir(
              path: element.name,
              isDirectory: false,
              categoryId: element.categoryId,
              price: element.price,
              id: element.id));
        });
    }
    setState(() {
      categoriesList = categories1;
      productsList = productList1;
    });
    print("asdsasaddsaasdsaasdsa");

    // files.add(FileorDir(path: "mobile/mmmm", isDirectory: true));
    // files.add(FileorDir(
    //     path: "mobile/image.jpg",
    //     isDirectory: false,
    //     imageURl:
    //         "https://cdn.mos.cms.futurecdn.net/BVb3Wzn9orDR8mwVnhrSyd-970-80.jpg"));

    // Directory dir = Directory(path);
    // List<FileSystemEntity> l = dir.listSync();
    // files.clear();
    // setState(() {
    //   showHidden =
    //       Provider.of<CategoryProvider>(context, listen: false).showHidden;
    // });
    // for (FileSystemEntity file in l) {
    //   if (!showHidden) {
    //     if (!pathlib.basename(file.path).startsWith(".")) {
    //       setState(() {
    //         files.add(file);
    //       });
    //     }
    //   } else {
    //     setState(() {
    //       files.add(file);
    //     });
    //   }
    // }

    // files = FileUtils.sortList(
    //     files, Provider.of<CategoryProvider>(context, listen: false).sort);
//    files.sort((f1, f2) => pathlib.basename(f1.path).toLowerCase().compareTo(pathlib.basename(f2.path).toLowerCase()));
//    files.sort((f1, f2) => f1.toString().split(":")[0].toLowerCase().compareTo(f2.toString().split(":")[0].toLowerCase()));
//    files.sort((f1, f2) => FileSystemEntity.isDirectorySync(f1.path) ==
//        FileSystemEntity.isDirectorySync(f2.path)
//        ? 0
//        : 1);
  }

  @override
  void initState() {
    super.initState();
    path = widget.path;
    getFiles();
    paths.add(widget.path);
    WidgetsBinding.instance.addObserver(this);
    enterPath = List();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  List<Widget> listData;

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    var currentFile = categoriesList[oldIndex];
    var switchFile = categoriesList[newIndex];
    if (currentFile.isDirectory == switchFile.isDirectory) {
      var result = currentFile.isDirectory
          ? await CategoryRepository()
              .changeOrder(currentFile.id, switchFile.id)
          : await ProductRepository()
              .changeOrder(currentFile.id, switchFile.id);
      if (result) {
        setState(
          () {
            getFiles();
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    listData = new List<Widget>();
    int indexx = 0;
    categoriesList.forEach((file) {
      //return file.toString().split(":")[0] == "Directory"
      listData.add(file.isDirectory == true
          ? DirectoryItem(
              key: Key('$indexx'),
              popTap: (v) async {
                if (v == 0) {
                  renameDialog(context, file.path, "dir", file.id);
                } else if (v == 1) {
                  var result = await CategoryRepository().delete(file.id);
                  if (result) setState(() {});
                  /*await Directory(file.path)
                                      .delete()
                                      .catchError((e) {
                                    print(e.toString());
                                    if (e
                                        .toString()
                                        .contains("Permission denied")) {
                                      Provider.of<CoreProvider>(context,
                                              listen: false)
                                          .showToast(
                                              "Cannot write to this Storage device!");
                                    }
                                  });
                                  */
                  await getFiles();
                }
              },
              file: file,
              tap: () {
                enterPath.add(file);
                categoriesList = new List<FileorDir>();
                print(file.path);
                paths.add(file.path);
                setState(() {
                  path = file.path;
                });
                getFiles();
              },
            )
          : FileItem(
              key: Key('$indexx'),
              file: file,
              popTap: (v) async {
                if (v == 0) {
                  renameDialog(context, file.path, "file", indexx);
                } else if (v == 1) {
                  // await File(file.path).delete().catchError((e) {
                  //   print(e.toString());
                  //   if (e
                  //       .toString()
                  //       .contains("Permission denied")) {
                  //     Provider.of<CoreProvider>(context,
                  //             listen: false)
                  //         .showToast(
                  //             "Cannot write to this Storage device!");
                  //   }
                  // });
                  getFiles();
                } else if (v == 2) {
                  print("Share");
                }
              },
            ));

      indexx++;
    });
    return WillPopScope(
      onWillPop: () async {
        if (paths.length == 1) {
          return true;
        } else {
          paths.removeLast();
          setState(() {
            path = paths.last;
          });
          getFiles();
          return false;
        }
      },
      child: Scaffold(
        // appBar: AppBar(

        //   elevation: 4,

        //   actions: <Widget>[
        //     IconButton(
        //       onPressed: () {
        //         showModalBottomSheet(
        //           context: context,
        //           builder: (context) => SortSheet(),
        //         ).then((v) {
        //           getFiles();
        //         });
        //       },
        //       tooltip: "Sort by",
        //       icon: Icon(
        //         Icons.sort,
        //       ),
        //     ),
        //   ],
        // ),
        body: Column(children: <Widget>[

            PathBar(
            child: Container(
              height: 50,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: enterPath.length,
                  itemBuilder: (BuildContext context, int index) {
                    String i = paths[index];
                    List splited = i.split("/");
                    return index == 0
                        ? Row(
                            children: <Widget>[
                              enterPath.length != 0
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.lightBlue,
                                      ),
                                      onPressed: () {
                                        if (enterPath.length == 0) {
                                          Navigator.pop(context);
                                        } else {
                                          enterPath.removeLast();
                                          paths.removeLast();
                                          
                                          getFiles();
                                        }
                                      },
                                    ),
                              IconButton(
                                icon: Icon(
                              
                                    Icons.restaurant_menu,
                                  color: index == enterPath.length - 1
                                      ? Colors.lightBlue
                                      : Colors.black,
                                ),
                                onPressed: () {
                                

                                    print("resturant is pressedddd");
                                setState(() {
                                   enterPath.clear();
                                });
                                 
                                  getFiles();
                                },
                              )
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              print(paths[index]);
                              setState(() {
                                print(index);
                                print(enterPath.length);
                                path = paths[index];

                                enterPath.removeRange(index, enterPath.length);
                                paths.removeRange(index + 1, paths.length);
                              });
                              getFiles();
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    "${splited[splited.length - 1]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: index == enterPath.length 
                                          ? Colors.lightBlue
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Icon(
                      Icons.arrow_forward_ios,
                    );
                  },
                ),
              ),
            ),
          ),
        
          categoriesList.isEmpty
              ? Center(
                  child: Text("There's nothing here"),
                )
              : Expanded(
                  child: ReorderableListView(
                    onReorder: _onReorder,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    children: listData,

                    // separatorBuilder: (BuildContext context, int index) {
                    //   return Stack(
                    //     children: <Widget>[
                    //       Align(
                    //         alignment: Alignment.centerRight,
                    //         child: Container(
                    //           height: 1,
                    //           color: Theme.of(context).dividerColor,
                    //           width: MediaQuery.of(context).size.width - 70,
                    //         ),
                    //       ),
                    //     ],
                    //   );
                    // },
                  ),
                ),
                
        ]),
        
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        parentCategoryId==null?SizedBox(height: 0,):FloatingActionButton(
            heroTag: "btn1",
            onPressed: () => addProductDialog(context, path),
            child: Icon(Icons.fastfood),
            tooltip: "Add Folder",
            backgroundColor: Colors.lightBlue,
          ),
          SizedBox(
            height: 5,
          ),
         parentCategoryId!=null?SizedBox(height: 0,): FloatingActionButton(
            heroTag: "btn2",
            onPressed: () => addCategoryDialog(context, path),
            child: Icon(Feather.folder_plus),
            tooltip: "Add Folder",
          ),
        ]),
      ),
    );
  }

  addCategoryDialog(BuildContext context, String path) {
    final TextEditingController name = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15),
              Text(
                "Add New Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 25),
              TextField(
                controller: name,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 130,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 130,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (name.text.isNotEmpty) {
                          dynamic parentCategoryId = null;
                          print(parentCategoryId);
                          if (enterPath.length > 0)
                            parentCategoryId = enterPath.last.id;
                          var catagory = await CategoryRepository()
                              .add(name.text, parentCategoryId);
                          if (catagory != null) {
                            // await Directory(path + "/${name.text}")
                            //     .create()
                            //     .catchError((e) {
                            //   print(e.toString());
                            //   if (e.toString().contains("Permission denied")) {
                            //     Provider.of<CoreProvider>(context,
                            //             listen: false)
                            //         .showToast(
                            //             "Cannot write to this Storage  device!");
                            //
                          }
                        } else {
                          // Provider.of<CoreProvider>(context, listen: false)
                          print("A Folder with that name already exists!");
                        }
                        Navigator.pop(context);
                        getFiles();
                      },
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  addProductDialog(BuildContext context, String path) {

 dynamic parentCategoryId = null;
    print(parentCategoryId);
    if (enterPath.length > 0) parentCategoryId = enterPath.last.id;
    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProduct(categoryId: parentCategoryId,updateExplorer: getFiles,
                       
                        )),
              );
              /*
    final AddProductBloc addProductBloc = new AddProductBloc();
      bool isVideo=false,isImage=false;

    dynamic categoryId = null;
    if (enterPath.length > 0) categoryId = enterPath.last.id;
    addProductBloc.changeCategoryId(categoryId);
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15),
              Text(
                "Add New Product",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 25),
              StreamBuilder<Object>(
                  stream: addProductBloc.submitRegisterStream,
                  builder: (context, snapshot) {
                     print("dsdsaas");
                    print(snapshot);
                     if(snapshot.hasData && snapshot.connectionState== ConnectionState.done )
                {
                  print("is looding offff");
                  Navigator.pop(context);
                 getFiles();
                }
                 print("is looding  waiiit");
                return Container();
                  }),
              productName(addProductBloc),
              price(addProductBloc),
              image(addProductBloc,isImage,isVideo),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 130,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 130,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if ("fdgfddg".isNotEmpty) {
                          addProductBloc.addRegister(true);
                           Navigator.pop(context);
                          //Dialogs.showLoadingDialog(context);
                          // var catagory = await CategoryRepository()
                          //   .add(name.text, parentCategoryId);
                          // if (catagory != null) {
                          // await Directory(path + "/${name.text}")
                          //     .create()
                          //     .catchError((e) {
                          //   print(e.toString());
                          //   if (e.toString().contains("Permission denied")) {
                          //     Provider.of<CoreProvider>(context,
                          //             listen: false)
                          //         .showToast(
                          //             "Cannot write to this Storage  device!");
                          //
                          // }
                        } else {
                          // Provider.of<CoreProvider>(context, listen: false)
                          print("A Folder with that name already exists!");
                        }
                       
                        getFiles();
                      },
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
    */
  }

  renameDialog(BuildContext context, String path, String type, int id) {
    final TextEditingController name = TextEditingController();
    setState(() {
      // name.text = pathlib.basename(path);
    });
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15),
              Text(
                "Rename Item",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 25),
              TextField(
                controller: name,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 130,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 130,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "Rename",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (name.text.isNotEmpty) {
                          await CategoryRepository().Edit(name.text, id);
                          //   if (type == "file") {
                          //     if (!File(path.replaceAll(
                          //                 pathlib.basename(path), "") +
                          //             "${name.text}")
                          //         .existsSync()) {
                          //       await File(path)
                          //           .rename(path.replaceAll(
                          //                   pathlib.basename(path), "") +
                          //               "${name.text}")
                          //           .catchError((e) {
                          //         print(e.toString());
                          //         if (e
                          //             .toString()
                          //             .contains("Permission denied")) {
                          //           Provider.of<CoreProvider>(context,
                          //                   listen: false)
                          //               .showToast(
                          //                   "Cannot write to this device!");
                          //         }
                          //       });
                          //     } else {
                          //       Provider.of<CoreProvider>(context, listen: false)
                          //           .showToast(
                          //               "A File with that name already exists!");
                          //     }
                          //   } else {
                          //     if (Directory(path.replaceAll(
                          //                 pathlib.basename(path), "") +
                          //             "${name.text}")
                          //         .existsSync()) {
                          //       Provider.of<CoreProvider>(context, listen: false)
                          //           .showToast(
                          //               "A Folder with that name already exists!");
                          //     } else {
                          //       await Directory(path)
                          //           .rename(path.replaceAll(
                          //                   pathlib.basename(path), "") +
                          //               "${name.text}")
                          //           .catchError((e) {
                          //         print(e.toString());
                          //         if (e
                          //             .toString()
                          //             .contains("Permission denied")) {
                          //           Provider.of<CoreProvider>(context,
                          //                   listen: false)
                          //               .showToast(
                          //                   "Cannot write to this device!");
                          //         }
                          //       });
                          //     }
                          //   }
                          Navigator.pop(context);
                          getFiles();
                        }
                      },
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Padding productName(AddProductBloc addProductBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: addProductBloc.productNameStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: addProductBloc.changeProductName,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.fastfood,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'Product name',
                hintText: 'Product name',
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
    );
  }

  Padding image(AddProductBloc addProductBloc, isImage,isVideo ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 10.0),
      child: StreamBuilder(
          stream: addProductBloc.fileStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[ IconButton(
                  icon: Icon(
                    Icons.image,
                    size: 50,
                    color:isImage? AppTheme.primaryColor:null,
                  ),
                  onPressed: () async {
                    var picture = await MultiMediaPicker.pickImages(
                        source: ImageSource.gallery);
                    if(picture!=null && picture.length>0)
                    addProductBloc.changeFile(picture[0]);
                isVideo=false;
                isImage=true;
                
                  },
                ),
                
                
                IconButton(
                icon: Icon(
                  Icons.video_library,
                  size: 50,
                  color: isVideo? AppTheme.primaryColor:null
                
                ),
                onPressed: () async {
                  var picture = await MultiMediaPicker.pickVideo(
                      source: ImageSource.gallery);
                  print(picture.path);
                  addProductBloc.changeFile(picture);
                  isVideo=true;
                isImage=false;

                 
                },
              )
                
                ]
              );
            } else {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "Add media",
                        style: AppTheme.body1,
                      ),
                    ),
                     IconButton(
                      icon: Icon(
                        Icons.image,
                        size: 50,
                      ),
                      onPressed: () async {
                       var picture = await MultiMediaPicker.pickImages(
                      source: ImageSource.gallery);
                  if(picture!=null && picture.length>0)
                  addProductBloc.changeFile(picture[0]);
                        isVideo=false;
                isImage=true;
                      
                      },
                    ),
                     IconButton(
                icon: Icon(
                  Icons.video_library,
                  size: 50,
                
                ),
                onPressed: () async {
                  var picture = await MultiMediaPicker.pickVideo(
                      source: ImageSource.gallery);
                  print(picture.path);
                  addProductBloc.changeFile(picture);
                isVideo=true;
                isImage=false;
                 
                },
              )
                  ]);
            }
          }),
    );
  }

  Padding price(AddProductBloc addProductBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: addProductBloc.priceStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: addProductBloc.changePrice,
              autocorrect: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.euro_symbol,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'price',
                hintText: 'price',
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
    );
  }
}
