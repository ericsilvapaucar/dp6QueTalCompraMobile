import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  static String tag = 'profile-page';

  @override
  State createState() {
    return _ProfilePage();
  }

}

class _ProfilePage extends State<ProfilePage> {

  Widget get profile {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0, left: 30.0),
      child: Column(
        children: <Widget>[
          buildInputField('Nombre'),
          buildInputField('Correo electronico'),
          buildInputField('Direccion'),
        ],
      ),
    );
  }

  Padding buildInputField(String hintText) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(10.0),
            hintStyle: TextStyle(
                color: Color(0xffcccccc),
                fontSize: 14.0
            ),
            labelStyle: TextStyle(
              color: Colors.red,
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 150.0,
                backgroundColor: Color(0xffff6600),
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Nombre', style: TextStyle(color: Colors.white),),
                  background: Container(
                    color: Color(0xffff6600),
                    child: Icon(Icons.account_circle),
                  ),
                ),
              )
            ];
          },
          body: Center(
            child: profile
          )
      ),
    );
  }
}