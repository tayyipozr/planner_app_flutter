import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/book_providers.dart';

class BooksToRead extends StatefulWidget {
  static const routeName = "/books-to-read";

  @override
  _BooksToReadState createState() => _BooksToReadState();
}

class _BooksToReadState extends State<BooksToRead> {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<Book>(context);
    List<BookItem> books = book.items.values.toList();
    List<BookItem> tempReaded = [];
    List<BookItem> tempUnread = [];

    book.items.values.forEach((element) {
      if (element.isRead == true) {
        tempReaded.add(element);
      } else {
        tempUnread.add(element);
      }
    });

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "Novermber",
      "December"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Reading"),
      ),
      body: Column(
        children: <Widget>[
          Text("Tip : It is recommended to read 5 book a month."),
          Expanded(
            child: ListView.builder(
              addAutomaticKeepAlives: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: months.length,
              itemBuilder: (ctx, idx) {
                bool idxModulus = idx % 2 == 0;
                int monthIdx = idx + 1;
                List<BookItem> readed = [];
                List<BookItem> unread = [];
                tempReaded.forEach((element) {
                  print(element.start.month);
                  print("idx:" + idx.toString());
                  if (element.start.month == monthIdx) {
                    readed.add(element);
                  }
                });
                tempUnread.forEach((element) {
                  if (element.start.month == monthIdx) {
                    unread.add(element);
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
                        child: Text("${months[idx]}"),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height / 4.3,
                        width: width / 1.4,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.brown,
                              width: 3,
                            ),
                            left: BorderSide(
                              color: idxModulus ? Colors.brown : Colors.white,
                              width: 2,
                            ),
                            right: BorderSide(
                              color: idxModulus ? Colors.white : Colors.brown,
                              width: 2,
                            ),
                          ),
                        ),
                        child: idxModulus
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: height / 4.8,
                                    width: 20.0 *
                                        (readed.length == null
                                            ? 0
                                            : readed.length),
                                    child: ListView.builder(
                                      reverse: idxModulus,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: readed.length,
                                      itemBuilder: (ctx, idx) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              readed[idx].isRead = false;
                                            });
                                          },
                                          child: Container(
                                            margin: idxModulus
                                                ? EdgeInsets.only(left: 5)
                                                : EdgeInsets.only(right: 5),
                                            width: 15,
                                            color: Color(0xFFFFBDB9),
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: Text(
                                                "${readed[idx].name}",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 20.0 * unread.length,
                                    width: width / 2.9,
                                    child: ListView.builder(
                                      reverse: idxModulus,
                                      itemCount: unread.length,
                                      itemBuilder: (ctx, idx) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              unread[idx].isRead = true;
                                            });
                                          },
                                          child: Container(
                                            margin: idxModulus
                                                ? EdgeInsets.only(top: 5)
                                                : EdgeInsets.only(bottom: 5),
                                            height: 15,
                                            color: Colors.brown[200],
                                            child: Text(
                                              "${unread[idx].name}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: 20.0 * unread.length,
                                    width: width / 2.9,
                                    child: ListView.builder(
                                      reverse: !idxModulus,
                                      itemCount: unread.length,
                                      itemBuilder: (ctx, idx) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              unread[idx].isRead = true;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: 15,
                                            color: Colors.brown[200],
                                            child: Text(
                                              "${unread[idx].name}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: height / 4.8,
                                    width: 20.0 * readed.length,
                                    child: ListView.builder(
                                      reverse: idxModulus,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: readed.length,
                                      itemBuilder: (ctx, idx) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              readed[idx].isRead = false;
                                            });
                                          },
                                          child: Container(
                                            margin: idxModulus
                                                ? EdgeInsets.only(left: 5)
                                                : EdgeInsets.only(right: 5),
                                            width: 15,
                                            color: Color(0xFFFFBDB9),
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: Text(
                                                "${readed[idx].name}",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: idxModulus ? width / 10 : width / 1.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.only(
                              bottomLeft: idxModulus
                                  ? Radius.circular(22)
                                  : Radius.zero,
                              bottomRight: idxModulus
                                  ? Radius.zero
                                  : Radius.circular(22),
                            ),
                          ),
                          height: 15,
                          width: 15,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: idxModulus ? width / 1.6 : width / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.only(
                              bottomRight: idxModulus
                                  ? Radius.circular(22)
                                  : Radius.zero,
                              bottomLeft: idxModulus
                                  ? Radius.zero
                                  : Radius.circular(22),
                            ),
                          ),
                          height: 15,
                          width: 15,
                        ),
                      ),
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
