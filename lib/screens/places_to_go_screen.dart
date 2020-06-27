import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class PlacesToGoScreen extends StatefulWidget {
  @override
  _PlacesToGoScreenState createState() => _PlacesToGoScreenState();
}

class _PlacesToGoScreenState extends State<PlacesToGoScreen>
    with TickerProviderStateMixin {
  AnimationController _cardAnimation;
  AnimationController _scaleAnimation;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  Animation<double> _scale;
  GifController _controller;
  bool animatedRight = false;

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
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomCard(FractionalOffset.topLeft, _backScale, _frontScale,
                    padding: height / 20,
                    cardTitle: "Europe",
                    imageUrl: "assets/img/continents/europe.png"),
                CustomCard(FractionalOffset.topCenter, _backScale, _frontScale,
                    cardTitle: "Asia",
                    imageUrl: "assets/img/continents/asia.png"),
                CustomCard(
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
          GestureDetector(
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
                width: size.width / 5,
                height: size.height / 5,
                alignment: Alignment.bottomCenter,
                controller: _controller,
                image: AssetImage(
                  'assets/img/map.gif',
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomCard(FractionalOffset.bottomLeft, _backScale, _frontScale,
                  cardTitle: "Oceania",
                  imageUrl: "assets/img/continents/australia.png"),
              CustomCard(FractionalOffset.bottomCenter, _backScale, _frontScale,
                  padding: height / 10,
                  cardTitle: "South America",
                  imageUrl: "assets/img/continents/south_america.png"),
              CustomCard(FractionalOffset.bottomRight, _backScale, _frontScale,
                  cardTitle: "Africa",
                  imageUrl: "assets/img/continents/africa.png")
            ],
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String cardTitle;
  final String imageUrl;
  final double padding;
  final Animation<double> _backScale;
  final Animation<double> _frontScale;
  AlignmentGeometry _geometry;

  CustomCard(
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
    return Container(
      padding: EdgeInsets.only(top: widget.padding),
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(22))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.cardTitle,
                    textAlign: TextAlign.center,
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
          GestureDetector(
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
            child: AnimatedBuilder(
              child: Container(
                  width: width / 4, height: height / 4, color: Colors.grey),
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
            ),
          ),
        ],
      ),
    );
  }
}
