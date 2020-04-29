import 'package:flutter/material.dart';
import 'package:instagraphy/screenshotPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userIdController = TextEditingController();
  final contestIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter your contest id',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),),
            TextField(
              controller: contestIdController,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                ),
                hintText: 'Mobile Number',
              ),
            ),
            SizedBox(height: 20,),
            Text('Enter your instagram id',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),),
            TextField(
              controller: userIdController,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                ),
                hintText: 'Mobile Number',
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(
                child: Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Submit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'BalooBhain2',
                      fontWeight: FontWeight.normal,
                    ),),
                  ),
                ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenshotPage(username: userIdController.text, contestId: contestIdController.text,)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
