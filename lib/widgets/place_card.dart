import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/place_provider.dart';
import '../widgets/place_bottom_sheet.dart';

class PlaceCard extends StatefulWidget {
  final int index_belong;
  final List data;
  final String cardTitle;
  final String imageUrl;
  final double padding;
  final Animation<double> _backScale;
  final Animation<double> _frontScale;
  final AlignmentGeometry _geometry;

  PlaceCard(
    this.index_belong,
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

class _CustomCardState extends State<PlaceCard> with TickerProviderStateMixin {
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
    final place = Provider.of<Place>(context);
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
                  Container(
                    width: width / 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: width / 6,
                          child: Text(
                            widget.cardTitle,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          width: width / 30,
                          child: IconButton(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            iconSize: 14,
                            icon: Icon(Icons.add),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) {
                                    return PlaceBottomSheet(
                                      belong: widget.index_belong,
                                    );
                                  });
                            },
                          ),
                        )
                      ],
                    ),
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
                child: Column(
                  children: [
                    Container(
                      child: Container(
                        width: width / 6,
                        child: Text(
                          "${widget.cardTitle}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 4,
                      thickness: 0.3,
                    ),
                    Container(
                      width: width / 4,
                      height: height / 5.5,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, idx) => Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 10.0),
                          child: Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: Key(data[idx].id),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.delete,
                                size: height / 45,
                                color: Colors.red,
                              ),
                            ),
                            onDismissed: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                Scaffold.of(context).showSnackBar(
                                  //place.removeItem(data[idx].id);
                                  SnackBar(
                                    content: Text(
                                        "${data[idx].name} deleted from ${widget.cardTitle}."),
                                    action: SnackBarAction(
                                      label: "UNDO",
                                      onPressed: () {
                                        print("bringed back");
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: width / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${(idx + 1).toString()} - " +
                                            "${data[idx].name}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      data[idx].visited
                                          ? Container(
                                              height: height / 40,
                                              width: width / 30,
                                              child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                icon: Icon(Icons.check_circle,
                                                    size: 14,
                                                    color: Colors.green),
                                                onPressed: () async {
                                                  await place.updateItem(
                                                      data[idx].id, false);
                                                  print(data[idx].visited);
                                                  Scaffold.of(context)
                                                      .showSnackBar(
                                                    //place.removeItem(data[idx].id);
                                                    SnackBar(
                                                      content: Text(
                                                          "${data[idx].name} removed from places i visit."),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              height: height / 40,
                                              width: width / 30,
                                              child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                icon: Icon(
                                                    Icons.check_circle_outline,
                                                    size: 14,
                                                    color: Colors.white),
                                                onPressed: () async {
                                                  await place.updateItem(
                                                      data[idx].id, true);

                                                  print(data[idx].visited);
                                                  Scaffold.of(context)
                                                      .showSnackBar(
                                                    //place.removeItem(data[idx].id);
                                                    SnackBar(
                                                      content: Text(
                                                          "${data[idx].name} added to places i visit."),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                    ],
                                  ),
                                  Divider(
                                    height: 2,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
