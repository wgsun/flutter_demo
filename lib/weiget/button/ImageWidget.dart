import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///通过按钮，我们可以响应用户的交互事件。Flutter 提供了三个基本的按钮控件，即
///FloatingActionButton、FlatButton 和 RaisedButton

class ButtonWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ButtonState();
  }

}

class _ButtonState extends State<ButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello world'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                color: Colors.yellow,
                //设置背景色为黄色
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                //设置斜角矩形边框
                colorBrightness: Brightness.light,
                //确保文字按钮为深色
                onPressed: () => print('FlatButton pressed'),
                child: Row(children: <Widget>[Icon(Icons.add), Text("Add")],)
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}