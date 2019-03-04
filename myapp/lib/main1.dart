import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'anim.dart';
void main() => runApp(SampleApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget{
  final String title;
  MyHomePage({this.title});
  @override
  Widget build(BuildContext context){
    // var typeList = List<String>();
    // for(num i=0;i<100;i++){
    //   typeList.add(i.toString());
    // }
    List<String> typeList = <String>[];

    TextEditingController _userNameControll = TextEditingController();
    TextEditingController _passwordControll = TextEditingController();

    FocusNode _uNameNode = FocusNode();
    FocusNode _pwdNode = FocusNode();
      for(num i=0;i<100;i++){
      typeList.add(i.toString());
    }

    GlobalKey _key = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: new Text(title),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin:EdgeInsets.fromLTRB(20,0,20,0),
              child: TextField(
              focusNode: _uNameNode,
              textInputAction: TextInputAction.search,
              controller: _userNameControll,
              autofocus: false,
              decoration: InputDecoration(
               hintText: '请输入用户名',
               contentPadding: EdgeInsets.all(20),
               border: InputBorder.none
               ),
               onChanged:(str){
                 RenderBox box = _key.currentContext.findRenderObject();
                               

               },
               onSubmitted: (str){
                  FocusScope.of(context).requestFocus(_pwdNode);
                  
               },
             ),
            ),
            Container(
              margin:EdgeInsets.fromLTRB(20,20,20,0),
              child:TextField(
              focusNode: _pwdNode,
              controller: _passwordControll,
               obscureText: true,
               autofocus: false,
               decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: '请输入密码',
                ),
             )
            ),
            Container(
              child: RaisedButton(
                padding: EdgeInsets.only(left: 100.0, right: 100.0),
                    key:_key ,
                   child:Text('登录'),
                   color: Color(0xff00ff00),
                   textColor: Color(0xffff0000),
                   onPressed: (){
                      print('${_userNameControll.text}\n');
                      print('${_passwordControll.text}\n');
                },
              )
            ),
          ],
        )
      )
    );

  }

}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
