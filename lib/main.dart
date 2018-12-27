import 'package:flutter/material.dart';
import 'package:flutter_hello/screen_api_get.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Hello';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final String assetName = 'assets/undraw_hello.svg';

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        tooltip: 'ADD',
        icon: const Icon(Icons.add),
        label: const Text('Add a new API'),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 16.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _modelBottomSheetMenu(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 24.0, top: 72.0),
            child: Text(
              'Hello Flutter',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 96.0)),
          Center(
            child: Column(
              children: <Widget>[
                new SvgPicture.asset(
                  assetName,
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _modelBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            height: 200,
            color: Color(0xFF737373),
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      child: Text(
                        'Select API type',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    FlatButton(
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Text(
                            'Call API - GET',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenAPIGet()));
                      },
                    ),
                    FlatButton(
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Color(0xFFE5EFFB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.0),
                                  bottomLeft: Radius.circular(24.0)),
                            )),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Text(
                                'Call API - POST',
                                style: TextStyle(
                                  color: Color(0xFF1976D2),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                )),
          );
        });
  }
}
