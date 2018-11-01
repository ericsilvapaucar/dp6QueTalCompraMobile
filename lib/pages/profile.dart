import 'package:flutter/material.dart';
import 'dart:math';

class ProfilePage extends StatefulWidget {

  static String tag = 'profile-page';

  @override
  State createState() {
    return _ProfilePage();
  }

}

class _ProfilePage extends State<ProfilePage> {

  var _controller = ScrollController();

  var _itemSelected = 0;

  set itemSelected(value) {
    setState(() {
      _itemSelected = value;
    });
  }

  var _heightBar = 130.0;
  var _radiusProfile = 60.0;

  static const MIN_HEIGHT = 50.0;
  static const BASE_HEIGHT = 130.0;

  double lerp(double a, double b, double t) {
    return (b - a) * t + a;
  }

  double inverseLerp(double a, double b, double value) {
    return (value - a) / (b - a);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var offset = _controller.position.pixels;
      var heightBar = BASE_HEIGHT;
      var compress = max(MIN_HEIGHT, heightBar - offset);

      var t = inverseLerp(MIN_HEIGHT, BASE_HEIGHT, compress);

//      print(compress);
      _radiusProfile = lerp(22.0, 60.0, t);

      setState(() {
        _heightBar = compress;
      });
    });
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget get profile {
    return Column(
      children: <Widget>[Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(child: Text("Mi perfil"), onPressed: () {
                    itemSelected = 0;
                  },), flex: 1,),
                Expanded(
                  child: FlatButton(child: Text("Historial"), onPressed: () {
                    itemSelected = 1;
                  },), flex: 1,),
                Expanded(
                  child: FlatButton(child: Text("Favorito"), onPressed: () {
                    itemSelected = 2;
                  },), flex: 1,),
              ],
            ),
          ),
          Stack(children: <Widget>[
            Container(
              width: double.infinity,
              height: 3.0,
              color: Color(0xffeeeeee),
            ),
            Positioned(
              left: 16.0 + (MediaQuery
                  .of(context)
                  .size
                  .width - 32.0) / 3 * _itemSelected,
              right: 16.0 + (MediaQuery
                  .of(context)
                  .size
                  .width - 32.0) / 3 * (2 - _itemSelected),
              child: Container(
                height: 3.0,
                color: Color(0xffff6600),
              ),
            ),
          ],),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          children: <Widget>[
            buildInputField('Nombre'),
            buildInputField('Correo electronico'),
            buildInputField('Direccion'),
            buildInputField('Direccion'),
            buildInputField('Direccion'),
            buildInputField('Direccion'),
            buildInputField('Direccion'),
            buildInputField('Direccion'),
          ],
        ),
      )
      ],
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
      appBar: AppBar(
        backgroundColor: Color(0xffff6600),
        elevation: 0.0,
        title: Text('Profile'),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(child: profileHeader, onPanUpdate: (e) {
            print(e.delta);
          },),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Eric Silva Paucar',
              style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: SingleChildScrollView(
                controller: _controller,
                child: profile
            ),
          ),
        ],
      ),
    );
  }

  Container get profileHeader {
    return Container(
      height: _heightBar,
      child: Stack(
        children: <Widget>[
          Container(
            height: _heightBar / 2.0,
            color: Color(0xffff6600),
          ),
          Center(
              child: Transform.translate(
                offset: Offset(-(60.0 - _radiusProfile) * 3.0, 0.0),
                child: Container(
                  width: _radiusProfile * 2,
                  height: _radiusProfile * 2,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://scontent.flim5-4.fna.fbcdn.net/v/t1.0-9/527953_134954853303057_1564908610_n.jpg?_nc_cat=109&_nc_ht=scontent.flim5-4.fna&oh=dee193bc443408e593e930e3ba248f21&oe=5C4C7E6C',),
                    backgroundColor: Colors.white,
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
