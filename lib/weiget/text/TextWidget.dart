import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///文本控件
class TextWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextState();
  }
}

class _TextState extends State<TextWidget> {
  TextStyle blackStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black); //黑色样式

  TextStyle redStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red); //红色样式

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
            /*Text(
              '文本是视图系统中的常见控件，用来显示一段特定样式的字符串，就比如Android里的TextView，或是iOS中的UILabel',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),*/
            Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '文本是视图系统中常见的控件，它用来显示一段特定样式的字符串，类似',
                    style: redStyle), //第1个片段，红色样式
                TextSpan(text: 'Android', style: blackStyle), //第1个片段，黑色样式
                TextSpan(text: '中的', style: redStyle), //第1个片段，红色样式
                TextSpan(text: 'TextView', style: blackStyle) //第1个片段，黑色样式
              ]),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
