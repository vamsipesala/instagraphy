import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenshotPage extends StatelessWidget {
  ScreenshotPage({@required this.username, @required this.contestId});
  String username;
  String contestId;

  @override
  Widget build(BuildContext context) {
    return F_ScreenshotPage(username: username, contestId: contestId);
  }
}

class F_ScreenshotPage extends StatefulWidget {
  F_ScreenshotPage({@required this.username, @required this.contestId});
  String username;
  String contestId;
  @override
  _F_ScreenshotPageState createState() => _F_ScreenshotPageState();
}

class _F_ScreenshotPageState extends State<F_ScreenshotPage> {
  bool isLoading =false;
  Future<File> ImageFile;
  String logotext = '';
  File _imageFile;
  double watermarkHeight = 50;
  double watermarkWidth = 50;
  ScreenshotController screenshotController = ScreenshotController();
  bool _progressBarActive = true;
//  final Permission _permission;
//  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

//  final myController = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      ImageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: ImageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
//            width: 300,
//            height: 300,
//            fit: BoxFit.fill,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget circularProgressBar(BuildContext context) {
    return new Scaffold(
        appBar:new AppBar(
          title: new Text("Circular progressbar demo"),
        ),
        body: _progressBarActive == true?const CircularProgressIndicator():new Container());
  }


  @override
  Widget build(BuildContext context) {
    return TransparentLoading(
      loading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Template Creation'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Screenshot(
                  controller: screenshotController,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: Image(image: AssetImage('images/Group175.jpg')),
                      ),
                      Positioned(
                        top: 55,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              color: Colors.transparent,
                              height: 290,
                              width: MediaQuery.of(context).size.width,
//                      width: 200,
                              child: showImage()
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Row(
                          children: <Widget>[
                            Image(image: AssetImage('images/instagramlogo.png'),
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(width: 3,),
                            Text('@',
                              style: TextStyle(
                                  fontFamily: 'BalooBhaina2',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),),
                            Text(widget.username,
                              style: TextStyle(
                                  fontFamily: 'BalooBhaina2',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  child: FlatButton(
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('Upload Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),)),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
//                      logotext = 'Logo';
                      });
                      pickImageFromGallery(ImageSource.gallery);
                      setState(() {
                        isLoading = false;
//                      logotext = 'Logo';
                      });
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: FlatButton(
                    onPressed: () async{
                      var status = await Permission.storage.status;
                      if (status.isUndetermined) {
                        Permission.storage.request();
                      }
//                      setState(() async{
//
//                      });
                     // _imageFile = null;
                      setState(() {
                        isLoading = true;
//                      logotext = 'Logo';
                      });
                      screenshotController
                          .capture(delay: Duration(milliseconds: 10),pixelRatio: 5)
                          .then((File image) async {
                        print("Capture Done");
                        setState(() {
                          _imageFile = image;
                          print(_imageFile);
                        });
                        await ImageGallerySaver.saveImage(image.readAsBytesSync());

                        setState(() {
                          isLoading = false;
//                      logotext = 'Logo';
                        });
//                    print(result);
                        print("File Saved to Gallery");
                        circularProgressBar(context);

                      }).catchError((onError) {
                        print(onError);
                      });
                    },
//                tooltip: 'Increment',
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('Save Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

