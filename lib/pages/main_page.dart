import 'dart:async';

import 'package:flutter/material.dart';
import 'package:que_tal_compra/components/indicator.dart';


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

  var _itemSelected = 0;
  var _itemsProducts = [1, 4, 5];
  int _categorySelected = -1;

  set itemSelected(value) {
    setState(() {
      _itemSelected = value;
    });
  }

  final _controller = PageController();

  final _colors = <Color> [
    Colors.blue,
    Colors.black38,
    Colors.blueGrey,
    Colors.cyanAccent,
    Colors.red
  ];


  @override
  void initState() {
    super.initState();
  }

  Container get banner {

    return Container(
      width: double.infinity,
      height: 150.0,
      alignment: Alignment.center,
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

  Container buildCategory(int rows) {

    var height = 150 * rows / 2.0;

    return Container(
      width: double.infinity,
      height: height,
      child: GridView.count(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
          crossAxisCount: rows,
          crossAxisSpacing: 14.0,
          scrollDirection: Axis.horizontal,
          mainAxisSpacing: 14.0,
          children: List.generate(10, (index) {

            var isCategorySelected = index == _categorySelected;
            var colorIcon = !isCategorySelected ? Color(0xffff6600) : Colors.white;
            var colorBackground = isCategorySelected ? Color(0xffff6600) : Colors.white;

            return GestureDetector(
              child: Container(
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
                                color: colorBackground,
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                            ),
                            child: Icon(Icons.category, color: colorIcon,)),
                      ),
                    ),
                    Container(height: 5.0),
                    Container(
                      child: Text("Relojes y Joyas",
                        style: TextStyle(
                            fontSize: 8.0,
                            color: Color(0xff4d4d4d),
                            fontWeight: isCategorySelected ? FontWeight.bold : FontWeight.normal
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  _categorySelected = index;
                });
              },
            );
          })
      ),
    );
  }

  Widget get products {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(child: Text("Novedades"), onPressed: () {
                      itemSelected = 0;
                    },), flex: 1,),
                  Expanded(
                    child: FlatButton(child: Text("Populares"), onPressed: () {
                      itemSelected = 1;
                    },), flex: 1,),
                  Expanded(
                    child: FlatButton(child: Text("Liquidacion"), onPressed: () {
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
        GridView.count(
            padding: EdgeInsets.only(top: 10.0),
            crossAxisCount: 2,
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: false),
            children: List.generate(_itemsProducts[_itemSelected], (index) {
              return productItem;
            })),
      ],
    );
  }

  Padding get productItem {
    return Padding(
      padding: const EdgeInsets.only(
          top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Center(child: Image(image: NetworkImage("https://www.quetalcompra.com/upload/goods/1_Celulares/107_Xiaomi/RedmiNote4_3GB_32GB_2.jpg"))),
                  Positioned(
                      right: 0.0,
                      bottom: 10.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                        child: Text('10.0%', style: TextStyle(color: Colors.white, fontSize: 12.0),),
                        color: Color(0xffff6600),))
                ],
              ),
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
                            child: Text("Xiaomi Parlante Bluetooth con stereo",
                              style: TextStyle(fontSize: 10.0),
                              textAlign: TextAlign.start,)),
                        Container(
                            alignment: Alignment.topLeft,
                            child: RichText(text: TextSpan(
                              text: "",
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'S/ 32.30',
                                  style: TextStyle(fontSize: 11.0, color: Colors.black54, decoration: TextDecoration.lineThrough),
                                ),
                                TextSpan(
                                  text: ' S/ 24.20',
                                  style: TextStyle(fontSize: 12.0, color: Colors.black)
                                ),
                              ]
                            ), textAlign: TextAlign.left,)),
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
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(children: <Widget>[
          banner,
          buildCategory(1),
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