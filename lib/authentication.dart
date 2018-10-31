import 'package:flutter/material.dart';
import 'home.dart';
import 'services/login.dart';


class MyHomePage extends StatefulWidget {

  static String tag = 'authetication-page';

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  bool _selected = false;

  AnimationController _controller;
  Animation<double> _scaleAnimation;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {

    _controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    var curve = CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller
    );

    _scaleAnimation = new Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _controller.dispose();
  }

  void setSelection(bool selected) {
    if (_selected == selected) return;

    _selected = selected;

    if (_selected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

  }

  @override
  Widget build(BuildContext context) {

    double _bottomSelection = 4.0;
    double _marginOptions = 64.0;
    double _scaleTextSelectionAdditional = 0.1;

    var mediaQuery = MediaQuery.of(context);

    double _width = mediaQuery.size.width;

    return new Scaffold(
      body: Column(
        children: <Widget>[
          buildHeader(_marginOptions, _scaleTextSelectionAdditional, _width, _bottomSelection),
          buildForm(),
          buildFooter()
        ],
      ),
    );
  }

  Container buildFooter() {

    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      return Container();
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  color: Color(0xffcccccc),
                  width: 60.0,
                  height: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("o Iniciar Sesión con"),
                ),
                Container(
                  color: Color(0xffcccccc),
                  width: 60.0,
                  height: 1.0,
                )
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  color: Colors.red,
                ),
                Container(
                  width: 50.0,
                ),
                Container(
                    width: 40.0,
                    height: 40.0,
                    color: Colors.blue
                )
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          )
        ],
      ),
    );
  }

  Padding buildForm() {

    if (!_selected) {
      // Authentication Form
      return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
        child: Column(
          children: <Widget>[
            buildInputField("Direccion de Email"),
            buildInputField("Constrasena"),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 10.0),
              child: FlatButton(
                padding: EdgeInsets.only(right: 0.0, left: 0.0),
                onPressed: () {
                  print("Olvide contrasena");
                },
                textColor: Color(0xffcccccc),
                child: Text("Olvidaste contrasena?",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: SizedBox(
                width: double.infinity,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    print("Pressed");
                    // Go to Home page
                    Navigator.of(context).pushReplacementNamed(HomePage.tag);

                  },
                  splashColor: Color(0xaaff4400),
                  color: Color(0xffff6600),
                  child: Text("Iniciar Sesion", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Registration Form
      return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          children: <Widget>[
            buildInputField("Nombre y Apellido"),
            buildInputField("Direccion de Email"),
            buildInputField("Constrasena"),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: SizedBox(
                width: double.infinity,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    print("Pressed");
//                    _showDialog();

                    fetch().then((post) {
                      print(post.title);
                      return post;
                    }, onError: (e) {
                      print(e);
                      throw e;
                    });

                  },
                  splashColor: Color(0xaaff4400),
                  color: Color(0xffff6600),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                            height: 20.0,
                            width: 20.0,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                        Container(
                          child: Text("Crear una Cuenta", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                          alignment: Alignment.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

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

  Container buildHeader(double _marginOptions, double _scaleTextSelectionAdditional, double _width, double _bottomSelection) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffff9400),
            Color(0xffff6600)
          ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)
      ),
      height: MediaQuery.of(context).viewInsets.bottom > 0 ? 60.0 : 200.0,
      child: new Stack(
        children: <Widget>[
          Container(
            child: new Image(
              image: new AssetImage("assets/graphics/ic_que_tal_compra_logo.png"),
              width: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 232.0,
              height: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 70.0,
            ),
            alignment: MediaQuery.of(context).viewInsets.bottom > 0 ? Alignment.centerLeft : Alignment.center,
            padding: EdgeInsets.all(10.0),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(left: _marginOptions, right: _marginOptions),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setSelection(true);
                    },
                    padding: EdgeInsets.only(bottom: 4.0 * _scaleAnimation.value),
                    child: Transform.scale(
                      scale: 1.0 + _scaleAnimation.value * _scaleTextSelectionAdditional,
                      child: Text("Registrate",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: _selected ? FontWeight.bold : FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setSelection(false);
                    },
                    padding: EdgeInsets.only(bottom: 4.0 * (1.0 - _scaleAnimation.value)),
                    child: Transform.scale(
                      scale: 1.0 + (1.0 - _scaleAnimation.value) * _scaleTextSelectionAdditional,
                      child: Text("Ingresar",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: !_selected ? FontWeight.bold : FontWeight.normal
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: calculateAnimation(_width, _marginOptions, 76.0, 1.0 - _scaleAnimation.value),
            child: Container(
              height: _bottomSelection,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: calculateAnimation(_width, _marginOptions, 76.0, _scaleAnimation.value),
            right: 0.0,
            child: Container(
              height: _bottomSelection,
              color: Colors.white,

            ),
          ),
        ],
      ),
    );
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    print("_showDialog");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(onPressed: () {}, child: Text("OK"))
          ],
        );
      },
    );
  }

  double calculateAnimation(double width, double margin, double text, double t) {

    var center = width - 2.0 * margin - 2.0 * text;
    return width - margin - (center + margin) * t;

  }
}