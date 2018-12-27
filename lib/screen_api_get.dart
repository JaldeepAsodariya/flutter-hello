import 'package:flutter/material.dart';
import 'package:flutter_hello/model/mdl_users.dart';

class ScreenAPIGet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GET: Users'),
      ),
      body: FutureBuilder<List<MdlUsers>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? UsersList(users: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  final List<MdlUsers> users;

  UsersList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0, bottom: 16.0),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return new Card(
          child: new Row(
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: Icon(
                  Icons.perm_identity,
                  size: 30.0,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                    left: 5.0, top: 10.0, right: 5.0, bottom: 10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      users[index].name,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    new Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 5.0, right: 0.0, bottom: 0.0)),
                    new Row(
                      children: <Widget>[
                        Icon(
                          Icons.pin_drop,
                          size: 20.0,
                        ),
                        new Text(users[index].address.city),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
