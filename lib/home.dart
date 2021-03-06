import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:que_tal_compra/services/login.dart';
import 'authentication.dart';
import 'pages/profile.dart';
import 'pages/main_page.dart';

import 'viewmodels/main_viewmodel.dart';

class HomePage extends StatefulWidget {

  static String tag = 'home-page';

  @override
  State createState() {
    return new _HomePage();
  }

}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin, MainViewContract {

  int _currentIndex = 0;
  ScrollController _scrollController = new ScrollController();
  bool _isVisible = true;

  AnimationController floatingAnimationController;
  Animation<double> floatingAnimation;

  MainPresenter _presenter;

  var _children;

  _HomePage() {
    _presenter = new MainPresenter(this);
  }


  @override
  void onLoadedUser(User user) {
    if (user != null) {
      print(user.name);
    }
  }

  @override
  void onFailedUser() {
    Navigator.of(context).pushReplacementNamed(MyHomePage.tag);
  }

  @override
  void initState() {

    super.initState();

    _children = <Widget>[
      MainPage(scrollController: _scrollController,),
      null,
      null,
      ProfilePage()
    ];

    _presenter.loadUser();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          if (_isVisible) {
            _isVisible = false;
            floatingAnimationController.forward();
          }
        });
      }

      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          if (!_isVisible) {
            _isVisible = true;
            floatingAnimationController.reverse();
          }
        });
      }
    });

    // Animation floating button
    floatingAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    floatingAnimation = Tween(begin: 1.0, end: 0.0)
        .animate(floatingAnimationController)
    ..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    floatingAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(
//        elevation: 0.0,
//        backgroundColor: Color(0xffff6600),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.access_time),
//            onPressed: () {
//
//            },
//          ),
//          IconButton(
//            icon: Icon(Icons.account_circle),
//            onPressed: () {
//              Navigator.of(context).pushNamed(ProfilePage.tag);
//            },
//          )
//        ],
//      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Buscar")),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text("Compras")),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("Perfil")),
      ], currentIndex: _currentIndex, onTap: (index) {
        setState(() {
          if (_children[index] != null) {
            _currentIndex = index;
          }
        });
      },type: BottomNavigationBarType.fixed,),
//      floatingActionButton: Opacity(
//        opacity: floatingAnimation.value,
//        child: FloatingActionButton(onPressed: () {
//
//        }, backgroundColor: Color(0xffff6600),
//        child: Icon(Icons.shopping_cart),),
//      ),
    );
  }


}
