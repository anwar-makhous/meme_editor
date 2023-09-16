import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final GlobalKey globalKey = new GlobalKey();

  Color currentColor = Colors.white;

  void changeColor(Color color) => setState(() => currentColor = color);

  double _fontSize = 25.0;

  Offset offset = Offset.zero;

  String headerText = "";
  String footerText = "";

  File _image;
  File _imageFile;

  bool imageSelected = false;

  Random rng = new Random();

   List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
//  Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.white,
    Colors.black,
  ];

  Future getImage() async {
    var image;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (platformException) {
      print("not allowing " + platformException);
    }
    setState(() {
      if (image != null) {
        imageSelected = true;
      } else {}
      _image = image;
    });
    new Directory('storage/emulated/0/' + 'MemeGenerator')
        .create(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                RepaintBoundary(
                  key: globalKey,
                  child: Stack(
                    children: <Widget>[
                      _image != null
                          ? Image.file(
                        _image,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitHeight,
                      )
                          : Container(),
                      Positioned(
                        left: offset.dx,
                        top: offset.dy,
                        child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                offset = Offset(
                                    offset.dx + details.delta.dx, offset.dy + details.delta.dy);
                              });
                            },
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    headerText.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: currentColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: _fontSize,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Colors.black87,
                                        ),
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                          color: Colors.black87,
                                        ),
                                      ],),

                                  ),
                                ),
                              ),
                            )),
                      ),
//                    Container(
//                      width: MediaQuery.of(context).size.width,
//                      height: 300,
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Container(
//                            padding: EdgeInsets.symmetric(vertical: 8),
//                            child: Text(
//                              headerText.toUpperCase(),
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.w700,
//                                  fontSize: 26,
//                                shadows: <Shadow>[
//                                  Shadow(
//                                    offset: Offset(2.0, 2.0),
//                                    blurRadius: 3.0,
//                                    color: Colors.black87,
//                                  ),
//                                  Shadow(
//                                    offset: Offset(2.0, 2.0),
//                                    blurRadius: 8.0,
//                                    color: Colors.black87,
//                                  ),
//                                ],),
//
//                            ),
//                          ),
//                          Spacer(),
//                          Container(
//                              padding: EdgeInsets.symmetric(vertical: 8),
//                              child: Text(
//                                footerText.toUpperCase(),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.w700,
//                                    fontSize: 26,
//                                  shadows: <Shadow>[
//                                    Shadow(
//                                      offset: Offset(2.0, 2.0),
//                                      blurRadius: 3.0,
//                                      color: Colors.black87,
//                                    ),
//                                    Shadow(
//                                      offset: Offset(2.0, 2.0),
//                                      blurRadius: 8.0,
//                                      color: Colors.black87,
//                                    ),
//                                  ],),
//                              ))
//                        ],
//                      ),
//                    ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                imageSelected
                    ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            headerText = val;
                          });
                        },
                        decoration: InputDecoration(hintText: "Type your text here"),
                      ),
//                          SizedBox(
//                            height: 12,
//                          ),
//                          TextField(
//                            onChanged: (val) {
//                              setState(() {
//                                footerText = val;
//                              });
//                            },
//                            decoration: InputDecoration(hintText: "Footer Text"),
//                          ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Change Size:', style: TextStyle(fontSize: 16),),
                          new NumberPicker.horizontal(
                            listViewHeight: 50,
                              initialValue: 25,
                              minValue: 10,
                              maxValue: 80,
                              step: 5,
                              highlightSelectedValue: false,
                              onChanged: (val){
                                setState(() {
                                  _fontSize = val*1.0;
                                  print(val);
                                });
                              }),
                        ],
                      ),
                      RaisedButton(
                        elevation: 3.0,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select a color'),
                                content: SingleChildScrollView(
                                  child: BlockPicker(
                                    availableColors: _colors,
                                    pickerColor: currentColor,
                                    onColorChanged: changeColor,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Change Color'),
                        color: currentColor,
                        textColor: useWhiteForeground(currentColor)
                            ? const Color(0xffffffff)
                            : const Color(0xff000000),
                      ),
                      RaisedButton(
                        onPressed: () {
                          //TODO
                          takeScreenshot();
                        },
                        child: Text("Save"),
                      )
                    ],
                  ),
                )
                    : Container(
                  child: Center(
                    child: Text("Select image to get started"),
                  ),
                ),
                _imageFile != null ? Image.file(_imageFile) : Container(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getImage();
          },
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File('$directory/screenshot${rng.nextInt(200)}.png');
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile);
    //saveFileLocal();
    imgFile.writeAsBytes(pngBytes);
  }

  _savefile(File file) async {
    await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
  }

  _askPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.photos]);
  }
}
