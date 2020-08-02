import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutterbarcode/scan.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Barcode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Barcode'),
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
  pindahHalaman() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Scan()));
  }

  prosesPindahhalaman() {
    var _durasi = new Duration(seconds: 3);
    return new Timer(_durasi, pindahHalaman);
  }

  @override
  void initState() {
    super.initState();
    prosesPindahhalaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
        ),
        Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'QR-Code\n&\nBarcode Scanner',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontFamily: "Anggada",
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
