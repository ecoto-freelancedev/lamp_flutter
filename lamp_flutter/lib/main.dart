import 'package:flutter/material.dart';
import 'package:torch/torch.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              _isOn ? 'On' : 'Off',
              style: TextStyle(
                fontSize: 25,
                color: _isOn ? Colors.white : Colors.black,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isOn ? Colors.white : Colors.black,
                  )),
              child: IconButton(
                icon: Icon(
                  Icons.highlight,
                ),
                color: _isOn ? Colors.white : Colors.black,
                iconSize: 100,
                onPressed: () {
                  if (_isOn == false) {
                    setState(() {
                      _isOn = true;
                    });
                    Torch.flashOn;
                  } else {
                    setState(() {
                      _isOn = false;
                    });
                    Torch.flashOff;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
