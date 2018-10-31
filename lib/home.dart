import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'services/login.dart';
import 'authentication.dart';
import 'pages/profile.dart';
import 'components/indicator.dart';

class HomePage extends StatefulWidget {

  static String tag = 'home-page';

  @override
  State createState() {
    return new _HomePage();
  }

}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  ScrollController _scrollController = new ScrollController();
  bool _isVisible = true;

  AnimationController floatingAnimationController;
  Animation<double> floatingAnimation;

  void _loadData() async {

    var userManager = UserManager.instance;

    if (userManager.user == null) {
      Navigator.of(context).pushReplacementNamed(MyHomePage.tag);
    }

  }

  @override
  void initState() {

    super.initState();

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
      appBar: AppBar(
        backgroundColor: Color(0xffff6600),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(ProfilePage.tag);
            },
          )
        ],
      ),
      body: MainPage(scrollController: _scrollController,),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new ListTile(
              title: Text("Home"),
              trailing: new Icon(Icons.home),
              onTap: () {
                _loadData();
                print("HOMA");
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.category), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.verified_user), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("Perfil")),
      ], currentIndex: _currentIndex, onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },type: BottomNavigationBarType.fixed,),
      floatingActionButton: Opacity(
        opacity: floatingAnimation.value,
        child: FloatingActionButton(onPressed: () {

        }, ),
      ),
    );
  }

}

class MainPage extends StatefulWidget {

  final ScrollController scrollController;

  MainPage({this.scrollController});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }

}

class _MainPage extends State<MainPage> {


  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;


  final _controller = PageController();

  final _colors = <Color> [
    Colors.blue,
    Colors.black38,
    Colors.blueGrey,
    Colors.cyanAccent,
    Colors.red
  ];

  Container get banner {
    return Container(
      width: double.infinity,
      height: 150.0,
      alignment: Alignment.center,
      color: Color(0xff552f74),
      child: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: _colors[index],
              );
            },
            controller: _controller,
            itemCount: _colors.length,
            physics: AlwaysScrollableScrollPhysics(),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: DotsIndicator(
                  controller: _controller,
                  itemCount: _colors.length,
                  onPageSelected: (int page) {
                    _controller.animateToPage(page, duration: _kDuration, curve: _kCurve);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container get category {
    return Container(
      width: double.infinity,
      height: 170.0,
      child: GridView.count(
        padding: EdgeInsets.all(20.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        scrollDirection: Axis.horizontal,
        mainAxisSpacing: 20.0,
        childAspectRatio: 1.0,
        children: List.generate(10, (index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffdbdbdb),
                          ),
                        borderRadius: BorderRadius.all(Radius.circular(7.0))
                      ),
                      child: Icon(Icons.category, color: Color(0xffff6600),)),
                  ),
                ),
                Container(height: 5.0),
                Container(
                  child: Text("Relojes y Joyas", style: TextStyle(fontSize: 8.0, color: Color(0xff4d4d4d)),),
                  alignment: Alignment.center,
                ),
              ],
            ),
          );
        })
      ),
    );
  }

  Container get products {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: FlatButton(child: Text("Novedades"), onPressed: () {},)),
              Expanded(child: FlatButton(child: Text("Populares"), onPressed: () {},)),
              Expanded(child: FlatButton(child: Text("Liquidacion"), onPressed: () {},)),
            ],
          ),
          Container(
            width: double.infinity,
            height: 3.0,
            color: Color(0xffeeeeee),
            child: Container(
              height: double.infinity,
              width: 10.0,
              color: Color(0xffff6600),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              children: List.generate(10, (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Icon(Icons.category, color: Color(0xffff6600),),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffefefef),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(7.0))
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("Xiaomi Parlante Bluetooth con stereo", style: TextStyle(fontSize: 10.0), textAlign: TextAlign.start,)),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("S/.89.90  S/.69.90", style: TextStyle(fontSize: 14.0), textAlign: TextAlign.left,)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.favorite_border, color: Color(0xffff6600),),
                          )
                        ],
                      )
                    ],
                  ),
                );
            })),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(children: <Widget>[
          banner,
          category,
          products
        ]),
      ),
    );
  }





  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));
    return null;
  }

}