import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import '../providers/place_provider.dart';
import '../screens/page_control_screen.dart';

class PlacesToGoScreen extends StatefulWidget {
  @override
  _PlacesToGoScreenState createState() => _PlacesToGoScreenState();
}

class _PlacesToGoScreenState extends State<PlacesToGoScreen>
    with TickerProviderStateMixin {
  AnimationController _cardAnimation;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  GifController _controller;
  bool animatedRight = false;
  bool _isLoading = false;

  @override
  void initState() {
    _cardAnimation = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _frontScale = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _cardAnimation,
      curve: Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = CurvedAnimation(
      parent: _cardAnimation,
      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _controller = GifController(
      value: 40,
      vsync: this,
      reverseDuration: Duration(seconds: 1),
      duration: Duration(seconds: 1),
    );
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Place>(context, listen: false).fetchAndSetPlaces();
      print("fetch working...");
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    List<List> datum = [[], [], [], [], [], []];
    final place = Provider.of<Place>(context);
    final places = place.items.values.toList();
    places.forEach((place) {
      datum[place.belong].add(place);
    });
    print(datum);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, PageControlScreen.routeName);
            }),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned(
                  top: height / 2.5,
                  left: width / 2.4,
                  child: InkWell(
                    onTap: () {
                      if (animatedRight) {
                        _cardAnimation.reverse();
                        _controller.animateBack(0).then((_) {
                          if (_controller.value == 0) {
                            _controller.value = 95;
                            _controller.animateBack(40);
                          }
                        });
                        animatedRight = false;
                      } else {
                        _cardAnimation.forward();
                        _controller.animateTo(95).then((_) {
                          if (_controller.value == 95) {
                            _controller.value = 0;
                            _controller.animateTo(40);
                          }
                        });
                        animatedRight = true;
                      }
                    },
                    child: GifImage(
                        height: height / 10,
                        fit: BoxFit.fill,
                        controller: _controller,
                        image: AssetImage(
                          'assets/img/map.gif',
                        )),
                  ),
                ),
                Positioned(
                  top: height / 50,
                  left: width / 12,
                  right: width / 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(datum[0], FractionalOffset.topLeft, _backScale,
                          _frontScale,
                          padding: height / 20,
                          cardTitle: "Europe",
                          imageUrl: "assets/img/continents/europe.png"),
                      CustomCard(datum[1], FractionalOffset.topCenter,
                          _backScale, _frontScale,
                          cardTitle: "Asia",
                          imageUrl: "assets/img/continents/asia.png"),
                      CustomCard(
                        datum[2],
                        FractionalOffset.topRight,
                        _backScale,
                        _frontScale,
                        padding: height / 20,
                        cardTitle: "America",
                        imageUrl: "assets/img/continents/america.png",
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: height / 50,
                  left: width / 12,
                  right: width / 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(datum[3], FractionalOffset.bottomLeft,
                          _backScale, _frontScale,
                          cardTitle: "Oceania",
                          imageUrl: "assets/img/continents/australia.png"),
                      CustomCard(datum[4], FractionalOffset.bottomCenter,
                          _backScale, _frontScale,
                          padding: height / 10,
                          cardTitle: "South America",
                          imageUrl: "assets/img/continents/south_america.png"),
                      CustomCard(datum[5], FractionalOffset.bottomRight,
                          _backScale, _frontScale,
                          cardTitle: "Africa",
                          imageUrl: "assets/img/continents/africa.png")
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final List data;
  final String cardTitle;
  final String imageUrl;
  final double padding;
  final Animation<double> _backScale;
  final Animation<double> _frontScale;
  final AlignmentGeometry _geometry;

  CustomCard(
    this.data,
    this._geometry,
    this._backScale,
    this._frontScale, {
    this.padding = 0,
    this.cardTitle = "undefined",
    this.imageUrl = "",
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with TickerProviderStateMixin {
  AnimationController _scaleAnimation;
  Animation<double> _scale;
  bool isScale = false;
  bool startScale = false;

  @override
  void initState() {
    _scaleAnimation = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _scale = Tween<double>(
      begin: 2,
      end: 5,
    ).animate(
      CurvedAnimation(
        parent: _scaleAnimation,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    var data = widget.data;
    return Container(
      padding: EdgeInsets.only(top: widget.padding),
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown[200],
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: width / 7.5,
                        child: Text(
                          widget.cardTitle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(0),
                        iconSize: 20,
                        icon: Icon(Icons.add),
                        onPressed: () => print("tapped"),
                      )
                    ],
                  ),
                  Image.asset(
                    widget.imageUrl,
                    height: height / 8,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
              width: width / 4,
              height: height / 4,
            ),
            animation: widget._frontScale,
            builder: (BuildContext context, Widget child) {
              final Matrix4 transform = Matrix4.identity()
                ..scale(widget._frontScale.value, 1.0, 1.0);
              return Transform(
                transform: transform,
                alignment: FractionalOffset.center,
                child: child,
              );
            },
          ),
          AnimatedBuilder(
            animation: startScale ? _scale : widget._backScale,
            builder: startScale
                ? (BuildContext context, Widget child) {
                    return Transform.scale(
                      alignment: widget._geometry,
                      scale: _scale.value / 2,
                      child: child,
                    );
                  }
                : (BuildContext context, Widget child) {
                    final Matrix4 transform = Matrix4.identity()
                      ..scale(widget._backScale.value, 1.0, 1.0);
                    return Transform(
                      transform: transform,
                      alignment: FractionalOffset.center,
                      child: child,
                    );
                  },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  startScale = true;
                  if (isScale) {
                    _scaleAnimation.reverse().then((_) {
                      isScale = false;
                      setState(() {
                        startScale = false;
                      });
                    });
                  } else {
                    _scaleAnimation.forward().then((_) {
                      isScale = true;
                    });
                  }
                });
              },
              child: Container(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, idx) => Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Text(
                        "${(idx + 1).toString()} - " + "${data[idx].name}"),
                  ),
                ),
                width: width / 4,
                height: height / 4,
                decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      offset: Offset(2.0, 2.0), //(x,y)
                      blurRadius: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
