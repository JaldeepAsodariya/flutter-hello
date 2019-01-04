import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hello/config/api_config.dart';
import 'package:flutter_hello/model/mdl_posts.dart';

class ScreenAPIPost extends StatefulWidget {
  @override
  _ScreenAPIPostState createState() => _ScreenAPIPostState();
}

class _ScreenAPIPostState extends State<ScreenAPIPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('POST: Create Posts'),
        ),
        body: Container(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 8.0),
            children: <Widget>[ScreenUI()],
          ),
        ));
  }
}

class ScreenUI extends StatefulWidget {
  @override
  _ScreenUIState createState() => _ScreenUIState();
}

class _ScreenUIState extends State<ScreenUI> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isLoading = false;
  MdlPostsReq _mdlPostsReq = new MdlPostsReq();
  MdlPostsRes _mdlPostsRes;

  String _validateTitle(String titleVal) {
    try {
      Validate.isAlphaNumeric(titleVal);
    } catch (e) {
      return 'Please enter post title';
    }
    return null;
  }

  String _validateBody(String bodyVal) {
    try {
      Validate.isAlphaNumeric(bodyVal);
    } catch (e) {
      return 'Please enter post body';
    }
    return null;
  }

  String _validateUserId(String userIdVal) {
    try {
      Validate.isAlphaNumeric(userIdVal);
    } catch (e) {
      return 'Please enter user id';
    }
    return null;
  }

  void checkAllValidation() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      writeNewPost();
      setState(() {
        isLoading = true; // Show ProgressIndicator
      });
    }
  }

  Future<Null> writeNewPost() async {
    final response = await http.Client().post(API_ROOT_URL + FUNCTION_POSTS,
        headers: {"Accept": "application/json"},
        body: requestJsonMap(
            _mdlPostsReq.title, _mdlPostsReq.body, _mdlPostsReq.userId),
        encoding: Encoding.getByName("utf-8"));

    setState(() {
      isLoading = false; // Show ProgressIndicator
      _mdlPostsRes = mdlPostsFromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetFieldsUI() {
      return Form(
        key: this._formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 16.0)),
            new Card(
              margin: new EdgeInsets.symmetric(horizontal: 24.0),
              child: new Column(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(top: 16.0)),
                  Text('CREATE NEW POST', style: TextStyle(fontSize: 18.0)),
                  new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter post title', labelText: 'Title'),
                        validator: this._validateTitle,
                        onSaved: (String value) {
                          this._mdlPostsReq.title = value;
                        }),
                  ),
                  new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter post body', labelText: 'Body'),
                        validator: this._validateBody,
                        onSaved: (String value) {
                          this._mdlPostsReq.body = value;
                        }),
                  ),
                  new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter user id', labelText: 'User Id'),
                        validator: this._validateUserId,
                        onSaved: (String value) {
                          this._mdlPostsReq.userId = value;
                        }),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 16.0)),
                  Container(
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 56.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Submit'),
                      onPressed: this.checkAllValidation,
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 16.0))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget widgetFutureAPIResult() {
      return FutureBuilder<MdlPostsRes>(builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return !isLoading && _mdlPostsRes != null
            ? APIResult(
                resultMdlPosts: _mdlPostsRes,
              )
            : Container();
      });
    }

    Widget widgetProgressIndicator =
        isLoading ? Center(child: CircularProgressIndicator()) : Container();

    return Container(
      child: Column(
        children: <Widget>[
          widgetFieldsUI(),
          widgetFutureAPIResult(),
          widgetProgressIndicator
        ],
      ),
    );
  }
}

class APIResult extends StatelessWidget {
  final MdlPostsRes resultMdlPosts;
  final String assetConfirmation = 'assets/undraw_confirmation.svg';
  final String assetError = 'assets/undraw_feeling_blue.svg';

  APIResult({Key key, this.resultMdlPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Card(
          margin: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: new Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 8.0)),
              new SvgPicture.asset(
                resultMdlPosts.id != 0 ? assetConfirmation : assetError,
                height: 110,
                width: 110,
              ),
              new Padding(padding: EdgeInsets.only(top: 8.0)),
              new Text(
                'Server insert id: ' + resultMdlPosts.id.toString(),
                style: TextStyle(fontSize: 24.0),
              ),
              new Padding(padding: EdgeInsets.only(bottom: 8.0)),
            ],
          ),
        ),
      ],
    );
  }
}
