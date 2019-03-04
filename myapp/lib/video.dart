import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class SecondScreen extends StatelessWidget {
  String _movieId = '208325';
  SecondScreen(this._movieId);

  final List<Tab> myTabs = <Tab>[
    new Tab(text: '语文'),
    new Tab(text: '数学'),
    new Tab(
      text: '英语',
    ),
  ];

  void _addOverlay(BuildContext context) async {
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    //创建OverlayEntry
    OverlayEntry _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Row(
              // child: Icon(Icons.check_circle),
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 SizedBox(
                    width: 30,
                    height: MediaQuery.of(context).size.height-80,
                    child: Container(
                      color: Colors.red
                    ),
                 ) , 
              
              ],
              
            ));
    //显示到屏幕上。
    overlayState.insert(_overlayEntry);
    //等待2秒
    await Future.delayed(Duration(seconds: 2));
    //移除
    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Container(
        child: Text('contain'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _addOverlay(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Row tabs() {
  //   return Row(
  //     mainAxisSize: MainAxisSize.max,
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: <Widget>[
  //       new Container(
  //         child: IconButton(
  //           icon: Icon(Icons.near_me),
  //           color: Colors.blue,
  //           onPressed: () {},
  //         ),
  //         color: Colors.red,
  //       ),
  //       IconButton(
  //         icon: Icon(Icons.edit_location),
  //         color: Colors.green,
  //         onPressed: () {},

  //       ),
  //     ],
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: MyApp(),
  //     bottomNavigationBar:tabs(),
  //     floatingActionButton: Builder(builder: (BuildContext context){
  //         return FloatingActionButton(
  //            onPressed: (){

  //            },
  //            child: Icon(Icons.add),
  //            shape: new CircleBorder(),
  //         );
  //     }),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //   );
  // }

//     @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: MyApp(),
// //      CupertinoTabBar 是IOS分格
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0,
//         onTap: (int index){

//         },
//         items: [
//           BottomNavigationBarItem(
//               title: new Text("Home"), icon: new Icon(Icons.home)),
//           BottomNavigationBarItem(
//               title: new Text("List"), icon: new Icon(Icons.list)),
//           BottomNavigationBarItem(
//               title: new Text("Message"), icon: new Icon(Icons.message)),
//         ],
//       ),
//     );
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: myTabs.length,
  //     child: Scaffold(
  //       body: TabBarView(
  //         children: myTabs.map((Tab tab) {
  //           return new Center(
  //             child: RaisedButton(
  //               onPressed: (){
  //                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
  //                       return MyApp();
  //                    }));
  //               },
  //               child: Text('1111'),
  //             )
  //             );
  //         }).toList(),
  //       ),
  //       bottomNavigationBar: Container(
  //         height: 59,
  //         child: TabBar(
  //           tabs: myTabs,
  //           isScrollable: false,
  //         ),
  //         color: Colors.green,
  //       ),
  //     ),
  //   );
  // }

  // Widget build(BuildContext context) {
  //   return new DefaultTabController(
  //     length: myTabs.length,
  //     child: new Scaffold(
  //       appBar: new AppBar(
  //         bottom: new TabBar(
  //           tabs: myTabs,
  //           isScrollable: true,
  //         ),
  //         title: Text('二'),
  //       ),
  //       body: new TabBarView(
  //         children: myTabs.map((Tab tab) {
  //           return new Center(child: new Text(tab.text));
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }
  // // @override
  // Widget build(BuildContext context) {

  //   return new Scaffold(
  //     appBar: new AppBar(
  //       title: new Text('第二个页面'),
  //       backgroundColor: Colors.green,
  //     ),
  //     body: _VideoWidget(_movieId),
  //   );
  // }

}

class _VideoWidget extends StatefulWidget {
  String _movieId;
  _VideoWidget(this._movieId);

  @override
  _VideoAppState createState() {
    return _VideoAppState(_movieId);
  }
}

class _VideoAppState extends State<_VideoWidget> {
  String url;

  String movieId;

  _VideoAppState(this.movieId);

  VideoPlayerController videoPlayerController;

  ChewieController chewieController;

  Chewie playerWidget;

  Map _detail;
  @override
  void initState() {
    _requestMovieDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        playerWidget ?? Container(),
      ],
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  _requestMovieDetail() async {
    try {
      String detailUrl =
          'https://ticket-api-m.mtime.cn/movie/detail.api?locationId=290&movieId=' +
              movieId;
      final http.Response response = await http.post(detailUrl);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      _detail = responseData['code'] == '1' ? responseData['data'] : null;
      url = _detail != null ? _detail['basic']['video']['url'] : '';

      videoPlayerController = VideoPlayerController.network(url);

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );

      playerWidget = Chewie(
        controller: chewieController,
      );

      setState(() {});
    } catch (e) {}
  }
}
