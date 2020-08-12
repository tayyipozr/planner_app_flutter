import 'package:flutter/material.dart';
import 'package:planner_app/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import '../providers/place_provider.dart';
import 'plan_control_screen.dart';

import '../widgets/place_card.dart';

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

    final title = AppLocalizations.of(context).translate("places-page");
    final cardTitles =
        AppLocalizations.of(context).translate("places-titles").split(',');

    return _isLoading
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
                    PlaceCard(0, datum[0], FractionalOffset.topLeft, _backScale,
                        _frontScale,
                        padding: height / 20,
                        cardTitle: cardTitles[0],
                        imageUrl: "assets/img/continents/europe.png"),
                    PlaceCard(1, datum[1], FractionalOffset.topCenter,
                        _backScale, _frontScale,
                        cardTitle: cardTitles[1],
                        imageUrl: "assets/img/continents/asia.png"),
                    PlaceCard(
                      2,
                      datum[2],
                      FractionalOffset.topRight,
                      _backScale,
                      _frontScale,
                      padding: height / 20,
                      cardTitle: cardTitles[2],
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
                    PlaceCard(3, datum[3], FractionalOffset.bottomLeft,
                        _backScale, _frontScale,
                        cardTitle: cardTitles[3],
                        imageUrl: "assets/img/continents/australia.png"),
                    PlaceCard(4, datum[4], FractionalOffset.bottomCenter,
                        _backScale, _frontScale,
                        padding: height / 10,
                        cardTitle: cardTitles[4],
                        imageUrl: "assets/img/continents/south_america.png"),
                    PlaceCard(5, datum[5], FractionalOffset.bottomRight,
                        _backScale, _frontScale,
                        cardTitle: cardTitles[5],
                        imageUrl: "assets/img/continents/africa.png")
                  ],
                ),
              ),
            ],
          );
  }
}
