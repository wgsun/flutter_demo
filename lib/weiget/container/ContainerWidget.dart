import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* return Scaffold(
      body: Container(
        child: Text('Container（容器）在UI框架中是一个很常见的概念，Flutter也不例外。'),
        padding:  EdgeInsets.all(20.0),
        margin: EdgeInsets.all(100.0),
        width: 100,
        height: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.0)
        ),
      ),
    );*/

    /*return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(44.0),
          child: Text('Container（容器）在UI框架中是一个很常见的概念，Flutter也不例外。'),
        ),
    );*/

    //return Scaffold(body: Center(child: Text('Hello')));

    /*return Scaffold(
      body: Container(
        child: Center(child: Text('Container（容器）在UI框架中是一个很常见的概念，Flutter也不例外。')),
        padding: EdgeInsets.all(20.0),
        // 内边距
        margin: EdgeInsets.all(50.0),
        // 外边距
        width: 180.0,
        height: 240,
        decoration: BoxDecoration(
          //Container样式
          color: Colors.red, // 背景色
          borderRadius: BorderRadius.circular(10.0),
        ), // 圆角边框
      ),
    );*/

    //Row的用法示范
    /*return Scaffold(
      body:  Row(
        children: <Widget>[
          Expanded(flex: 1, child: Container(color: Colors.yellow, height: 80)),
          Container(color: Colors.red, width: 100, height: 180,),
          Container(color: Colors.black, width: 60, height: 80,),
          Expanded(flex: 1, child: Container(color: Colors.green, height: 80))
        ],
      ),
    );*/

    //Column的用法示范
    /*return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.yellow,
            width: 60,
            height: 80,
          ),
          Container(
            color: Colors.red,
            width: 100,
            height: 180,
          ),
          Container(
            color: Colors.black,
            width: 60,
            height: 80,
          ),
          Container(
            color: Colors.green,
            width: 60,
            height: 80,
          ),
        ],
      ),
    );*/

    //mainAxisAlignment
    /*return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //由于容器与子Widget一样宽，因此这行设置排列间距的代码并未起作用
        mainAxisSize: MainAxisSize.min,
        //让容器宽度与所有子Widget的宽度一致
        children: <Widget>[
          Container(
            color: Colors.yellow,
            width: 60,
            height: 80,
          ),
          Container(
            color: Colors.red,
            width: 100,
            height: 180,
          ),
          Container(
            color: Colors.black,
            width: 60,
            height: 80,
          ),
          Container(
            color: Colors.green,
            width: 60,
            height: 80,
          ),
        ],
      ),
    );*/

    //Stack 提供了层叠布局的容器，而 Positioned 则提供了设置子 Widget 位置的能力
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Colors.yellow, width: 300, height: 300), //黄色容器
          Positioned(
            left: 18.0,
            top: 18.0,
            child: Container(
                color: Colors.green, width: 50, height: 50), //叠加在黄色容器之上的绿色控件
          ),
          Positioned(
            left: 18.0,
            top: 70.0,
            child: Text("Stack提供了层叠布局的容器"), //叠加在黄色容器之上的文本
          )
        ],
      ),
    );
  }
}
