import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:torch/torch.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _hasFlash = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    // make sure release any resources held by the torch
    Torch.flashDispose;
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    bool hasFlash = false;
    try {
      hasFlash = await Torch.hasFlash;
    } on PlatformException {
      print('Failed to see if has flash.');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _hasFlash = hasFlash;
    });
  }

  Widget _getOnButton() {
    if (_hasFlash == false) {
      return Container();
    }
    return Align(
      alignment: const Alignment(0.0, 0.0),
      child: RaisedButton(
        color: Colors.green,
        child: Text('On', style: TextStyle(color: Colors.grey[200], fontSize: 15.0, fontWeight: FontWeight.bold)),
        onPressed: () {
          try {
            Torch.flashOn;
          } on PlatformException {
            print('Failed to turn camera on.');
          }
        },
      ),
    );
  }

  Widget _getOffButton() {
    if (_hasFlash == false) {
      return Container();
    }
    return Align(
      alignment: const Alignment(0.0, 0.0),
      child: RaisedButton(
        color: Colors.red,
        child: Text('Off', style: TextStyle(color: Colors.grey[200], fontSize: 15.0, fontWeight: FontWeight.bold)),
        onPressed: () {
          try {
            Torch.flashOff;
          } on PlatformException {
            print('Failed to turn camera off.');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Torch Example App'),
        ),
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Your device has ' + ((_hasFlash) ? "a FLASH" : "no FLASH")),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _getOnButton(),
                      _getOffButton(),
                    ]
                  )
                ]
              )
            ]
          )
        ),
      ),
    );
  }
}
