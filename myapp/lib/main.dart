import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'video.dart';

void main() {
  runApp(MyApp());
}

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

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});
  @override
  ListPage createState() => ListPage();
}

class ListPage extends State {
  List _resultList;
  int _rowCount = 0;
  int _lastcoloumCount = 0;
  @override
  void initState() {
    super.initState();
    _requestVideoPrd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: _rowCount,
              itemExtent: 100,
              itemBuilder: (context, item) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 0),
                      opacity: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (_) {
                            return SecondScreen(_resultList[item * 3]['movieId'].toString() ?? '');
                          }));
                        },
                        child: Column(
                          children: <Widget>[
                            FadeInImage.assetNetwork(
                              image: _resultList[item * 3]['img'] ?? '',
                              width: 70,
                              height: 70,
                              alignment: Alignment.center,
                              placeholder: 'moon.png',
                            ),
                            Container(
                              child: Text(
                                _resultList[item * 3]['titleCn'] ?? '',
                                style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.center,
                              ),
                              width: 70,
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 0),
                      opacity: (item + 1 == _rowCount && _lastcoloumCount >= 2)
                          ? 0
                          : 1,
                      child: GestureDetector(
                        onTap: (item + 1 == _rowCount && _lastcoloumCount >= 2)
                            ? null
                            : () {
                                Navigator.of(context)
                                    .push(new MaterialPageRoute(builder: (_) {
                                  return SecondScreen(_resultList[item * 3 + 1]['movieId'].toString() ?? '',);
                                }));
                              },
                        child: Column(
                          children: <Widget>[
                            FadeInImage.assetNetwork(
                              image: (item + 1 == _rowCount &&
                                      _lastcoloumCount >= 2)
                                  ? ''
                                  : _resultList[item * 3 + 1]['img'] ?? '',
                              width: 70,
                              height: 70,
                              placeholder: 'moon.png',
                            ),
                            Container(
                              child: Text(
                                (item + 1 == _rowCount && _lastcoloumCount >= 2)
                                    ? ''
                                    : _resultList[item * 3 + 1]['titleCn'] ??
                                        '',
                                style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.center,
                              ),
                              width: 70,
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 0),
                      opacity: (item + 1 == _rowCount && _lastcoloumCount >= 1)
                          ? 0
                          : 1,
                      child: GestureDetector(
                        onTap: (item + 1 == _rowCount && _lastcoloumCount >= 1)
                            ? null
                            : () {
                                Navigator.of(context)
                                    .push(new MaterialPageRoute(builder: (_) {
                                  return SecondScreen(_resultList[item * 3 + 2]['movieId'].toString() ?? '',);
                                }));
                              },
                        child: Column(
                          children: <Widget>[
                            FadeInImage.assetNetwork(
                              image: (item + 1 == _rowCount &&
                                      _lastcoloumCount >= 1)
                                  ? ''
                                  : _resultList[item * 3 + 2]['img'] ?? '',
                              width: 70,
                              height: 70,
                              placeholder: 'moon.png',
                            ),
                            Container(
                              child: Text(
                                (item + 1 == _rowCount && _lastcoloumCount >= 1)
                                    ? ''
                                    : _resultList[item * 3 + 2]['titleCn'] ??
                                        '',
                                style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.center,
                              ),
                              width: 70,
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }

  _requestVideoPrd() async {
    try {
      final http.Response response = await http.post(
          "https://api-m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=290");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      List resultDataList = responseData['movies'] ?? (new List());
      setState(() {
        _resultList = resultDataList;
        _rowCount = (resultDataList.length / 3 - resultDataList.length ~/ 3) > 0
            ? ((resultDataList.length ~/ 3) + 1)
            : resultDataList.length ~/ 3;
        _lastcoloumCount = 3 * _rowCount - resultDataList.length;
      });
    } catch (e) {
      print(e);
    }
  }
}
