//在 Dart 中，实际上有两个队列，一个事件队列（Event Queue），另一个则是微任务队列（Microtask Queue）。
// 在每一次事件循环中，Dart 总是先去第一个微任务队列中查询是否有可执行的任务，如果没有，才会处理后续的事件队列的流程。

//一般的异步任务通常也很少必须要在事件队列前完成，所以也不需要太高的优先级，因此我们通常很少会直接用到微任务队列，
//就连 Flutter 内部，也只有 7 处用到了而已（比如，手势识别、文本输入、滚动视图、保存页面效果等需要高优执行任务的场景）。
//异步任务我们用的最多的还是优先级更低的 Event Queue。比如，I/O、绘制、定时器这些异步事件，都是通过事件队列驱动主线程执行的。

import 'dart:async';

import 'dart:isolate';

import 'package:flutter/foundation.dart';

sample1() {
  Future(() => print('f1'));
  Future(() => print('f2'));
  //f3执行后会立刻同步执行then 3
  Future(() => print('f3')).then((value) => print('then 3'));
  //then 4会加入微任务队列，尽快执行
  Future(() => null).then((value) => print('then 4'));
}

sample2() {
  Future(() => print('f1')); //声明一个匿名Future
  Future fx = Future(() => null); //声明Future fx，其执行体为null

  //声明一个匿名Future，并注册了两个then。在第一个then回调里启动了一个微任务
  Future(() => print('f2')).then((value) {
    print('f3');
    scheduleMicrotask(() => print('f4'));
  }).then((value) => print('f5'));

  //声明了一个匿名Future，并注册了两个then。第一个then是一个Future
  Future(() => print('f6'))
      .then((value) => Future(() => print('f7')))
      .then((value) => print('f8'));
  //声明了一个匿名Future
  Future(() => print('f9'));

  //往执行体为null的fx注册了了一个then
  fx.then((value) => print('f10'));

  //启动一个微任务
  scheduleMicrotask(() => print('f11'));
  print('f12');
}

Future<String> fetchContent() =>
    Future<String>.delayed(Duration(seconds: 2), () => 'Hello')
        .then((value) => '$value 2019');

sample4() {
  Future(() => print('f1'))
      .then((value) async => await Future(() => print('f2'))).then((value) => print('f3'));
  Future(() => print('f4'));
}

func() async => print(await fetchContent());

//Isolate Dart 多线程机制
doSth(msg) => print(msg);

Isolate isolate;
start() async {
  ReceivePort receivePort = ReceivePort();//创建管道
  //创建并发Isolate，并传入发送管道

  isolate = await Isolate.spawn(getMsg, receivePort.sendPort);
  //监听管道消息
  receivePort.listen((data) {
    print('Data: $data');
    receivePort.close(); //关闭管道
    isolate.kill(priority: Isolate.immediate); //杀死并发Isolate
    isolate = null;
  });

}

getMsg(sendPort) => sendPort.send('hello');

//并发计算阶乘
Future<dynamic> asyncFactoriali(n) async{
  final response = ReceivePort();//创建管道
  //创建并发Isolate，并传入管道
  await Isolate.spawn(_isolate,response.sendPort);
  //等待Isolate回传管道
  final sendPort = await response.first as SendPort;
  //创建了另一个管道answer
  final answer = ReceivePort();
  //往Isolate回传的管道中发送参数，同时传入answer管道
  sendPort.send([n,answer.sendPort]);
  return answer.first;//等待Isolate通过answer管道回传执行结果
}

//Isolate函数体，参数是主Isolate传入的管道
_isolate(initialReplyTo) async {
  final port = ReceivePort();//创建管道
  initialReplyTo.send(port.sendPort);//往主Isolate回传管道
  final message = await port.first as List;//等待主Isolate发送消息(参数和回传结果的管道)
  final data = message[0] as int;//参数
  final send = message[1] as SendPort;//回传结果的管道 
  send.send(syncFactorial(data));//调用同步计算阶乘的函数回传结果
}

//同步计算阶乘
int syncFactorial(n) => n < 2 ? n : n * syncFactorial(n-1);

void main() async {
  print(".......sample1.......");
  sample1();
  await Future.delayed(const Duration(seconds: 1), () => print('.......sample2.......'));
  sample2();
  await Future.delayed(const Duration(seconds: 1), () => print(".......sample3......."));
  print(await fetchContent()); //等待Hello 2019的返回
  await Future.delayed(const Duration(seconds: 1), () => print(".......sample4......."));
  sample4();
  await Future.delayed(const Duration(seconds: 1), () => print(".......sample5......."));
  print("func before");
  func();
  print("func after");
  await Future.delayed(const Duration(seconds: 2), () => print(".......sample6......."));
  Isolate.spawn(doSth, "Hi");
  await Future.delayed(const Duration(seconds: 1), () => print(".......sample7......."));
  start();
  await Future.delayed(const Duration(seconds: 1), () => print(".......sample8......."));
  //print(await asyncFactoriali(4));
  print(await compute(syncFactorial, 4));
}
