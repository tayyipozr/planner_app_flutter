import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planner_app/app_localizations.dart';
import 'package:provider/provider.dart';

import '../screens/book_details_screen.dart';
import 'plan_control_screen.dart';

import '../widgets/book_bottom_sheet.dart';

import '../models/book.dart';

import '../providers/book_providers.dart';

class BooksToRead extends StatefulWidget {
  static const routeName = "/books-to-read";
  @override
  _BooksToReadState createState() => _BooksToReadState();
}

class _BooksToReadState extends State<BooksToRead> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Book>(context, listen: false).fetchAndSetBooks().then((_) => {
            setState(() {
              _isLoading = false;
            })
          });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<Book>(context);
    List<BookItem> books = book.items.values.toList();
    final bookshelfColor = Colors.purple[50];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // localizations
    final title = AppLocalizations.of(context).translate('yearly-book-page');
    final months = AppLocalizations.of(context).translate('months').split(",");
    final tip = AppLocalizations.of(context).translate('book-page-tip');

    return Scaffold(
      backgroundColor: bookshelfColor,
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, PlanControlScreen.routeName);
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BookBottomSheet();
                  },
                );
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Text(tip),
          Expanded(
            child: ListView.builder(
              addAutomaticKeepAlives: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: months.length,
              itemBuilder: (ctx, idx) {
                bool idxModulus = idx % 2 == 0;
                int idxMonth = idx + 1;
                List tempMonth = [];
                books.forEach((element) {
                  if (element.start.month == idxMonth) {
                    tempMonth.add(element);
                  }
                });
                return Container(
                  padding: idxModulus
                      ? EdgeInsets.only(left: 10)
                      : EdgeInsets.only(right: 10),
                  child: Stack(
                    alignment: idxModulus
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        child: Text(
                          "${months[idx]}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Positioned(
                        top: height / 6,
                        width: width / 1.3,
                        left: idxModulus ? width / 30 : null,
                        right: idxModulus ? null : width / 30,
                        child: Image.asset("assets/img/shelf.png"),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height / 4,
                        width: width / 1.3,
                        //   decoration: BoxDecoration(
                        //     border: Border(
                        //       bottom: BorderSide(
                        //         color: Colors.brown,
                        //         width: 3,
                        //       ),
                        // left: BorderSide(
                        //   color: idxModulus ? Colors.brown : bookshelfColor,
                        //   width: 2,
                        // ),
                        // right: BorderSide(
                        //   color: idxModulus ? bookshelfColor : Colors.brown,
                        //   width: 2,
                        // ),
                        //   ),
                        //),
                        child: idxModulus
                            ? Container(
                                height: height / 5,
                                width: width / 3,
                                padding: EdgeInsets.only(
                                  left: width / 25,
                                  bottom: height / 15,
                                ),
                                child: ListView.builder(
                                  reverse: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tempMonth.length,
                                  itemBuilder: (ctx, idx) {
                                    return GestureDetector(
                                      onDoubleTap: () {
                                        setState(() {
                                          book.updateItem(BookItem(
                                            id: tempMonth[idx].id,
                                            isRead: !tempMonth[idx].isRead,
                                          ));
                                        });
                                      },
                                      onLongPress: () {
                                        Navigator.pushNamed(
                                            context, BookDetailScreen.routeName,
                                            arguments: tempMonth[idx].id);
                                      },
                                      child: tempMonth[idx].isRead
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/book_middle.png",
                                                  width: width / 16,
                                                ),
                                                RotatedBox(
                                                  quarterTurns: 3,
                                                  child: Text(
                                                    tempMonth[idx].name,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/book_purple.png",
                                                  width: width / 16,
                                                ),
                                                RotatedBox(
                                                  quarterTurns: 3,
                                                  child: Text(
                                                    tempMonth[idx].name,
                                                  ),
                                                )
                                              ],
                                            ),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                height: height / 5,
                                width: width / 3,
                                padding: EdgeInsets.only(
                                  right: width / 25,
                                  bottom: height / 15,
                                ),
                                child: ListView.builder(
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tempMonth.length,
                                  itemBuilder: (ctx, idx) {
                                    return GestureDetector(
                                      onDoubleTap: () {
                                        setState(() {
                                          book.updateItem(BookItem(
                                            id: tempMonth[idx].id,
                                            isRead: !tempMonth[idx].isRead,
                                          ));
                                        });
                                      },
                                      onLongPress: () {
                                        Navigator.pushNamed(
                                            context, BookDetailScreen.routeName,
                                            arguments: tempMonth[idx].id);
                                      },
                                      child: tempMonth[idx].isRead
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Hero(
                                                  tag: tempMonth[idx].id,
                                                  child: Image.asset(
                                                    "assets/img/book_middle.png",
                                                    width: width / 16,
                                                  ),
                                                ),
                                                RotatedBox(
                                                    quarterTurns: 3,
                                                    child: Text(
                                                        tempMonth[idx].name))
                                              ],
                                            )
                                          : Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/book_purple.png",
                                                  width: width / 16,
                                                ),
                                                RotatedBox(
                                                  quarterTurns: 3,
                                                  child: Text(
                                                    tempMonth[idx].name,
                                                  ),
                                                )
                                              ],
                                            ),
                                    );
                                  },
                                ),
                              ),
                      ),

                      // Positioned(
                      //   bottom: 5,
                      //   left: idxModulus ? width / 10 : width / 1.2,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.brown,
                      //       borderRadius: BorderRadius.only(
                      //         bottomLeft: idxModulus
                      //             ? Radius.circular(22)
                      //             : Radius.zero,
                      //         bottomRight: idxModulus
                      //             ? Radius.zero
                      //             : Radius.circular(22),
                      //       ),
                      //     ),
                      //     height: 15,
                      //     width: 15,
                      //   ),
                      // ),
                      // Positioned(
                      //   bottom: 5,
                      //   left: idxModulus ? width / 1.6 : width / 3,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.brown,
                      //       borderRadius: BorderRadius.only(
                      //         bottomRight: idxModulus
                      //             ? Radius.circular(22)
                      //             : Radius.zero,
                      //         bottomLeft: idxModulus
                      //             ? Radius.zero
                      //             : Radius.circular(22),
                      //       ),
                      //     ),
                      //     height: 15,
                      //     width: 15,
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
