import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// List控件

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            ParallelWidget(),
            ScrollNotificationWidget(),
            ScrollControllerWidget(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: '视差'),
            Tab(icon: Icon(Icons.rss_feed), text: 'Notification'),
            Tab(
              icon: Icon(Icons.perm_identity),
              text: 'Controller',
            )
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}

class ParallelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('CustomScrollView Demo'),
          floating: true,
          flexibleSpace: Image.network(
              "https://media-cdn.tripadvisor.com/media/photo-s/13/98/8f/c2/great-wall-hiking-tours.jpg",
              fit: BoxFit.cover),
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text('Item #$index')),
              childCount: 100),
        ),
      ],
    );
  }
}

class ScrollNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scroll Notification Demo',
        home: Scaffold(
          appBar: AppBar(title: Text('ScrollController Demo')),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                // 滚动开始
                print('Scroll Start');
              } else if (scrollNotification is ScrollUpdateNotification) {
                // 滚动位置更新
                print('Scroll Update');
              } else if (scrollNotification is ScrollEndNotification) {
                // 滚动结束
                print('Scroll End');
              }
            },
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) =>
                    ListTile(title: Text('Index: $index'))),
          ),
        ));
  }
}

class ScrollControllerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScrollControllerState();
}

class _ScrollControllerState extends State<ScrollControllerWidget> {
  ScrollController _controller;
  bool isToTop = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 1000) {
        setState(() {
          isToTop = true;
        });
      } else if (_controller.offset < 300) {
        setState(() {
          isToTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scroll Controller Widger')),
      body: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            child: RaisedButton(
              onPressed: (isToTop
                  ? () {
                      if (isToTop) {
                        _controller.animateTo(.0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease); // 做一个滚动到顶部的动画
                      }
                    }
                  : null),
              child: Text("Top"),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  controller: _controller,
                  itemCount: 100,
                  itemBuilder: (context, index) => ListTile(
                        title: Text("Index : $index"),
                      )))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
