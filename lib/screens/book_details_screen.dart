import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/book_providers.dart';
import '../models/book.dart';

class BookDetailScreen extends StatefulWidget {
  static const routeName = "/book-detail";

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final bookId = ModalRoute.of(context).settings.arguments as String;
    final book = Provider.of<Book>(context);
    BookItem bookItem;
    List<BookItem> books = book.items.values.toList();
    books.forEach((element) {
      if (element.id == bookId) {
        bookItem = element;
      }
    });

    List ratingList = [];
    for (var i = 0; i < 5; i++) {
      if (i < bookItem.rating) {
        ratingList.add(false);
      } else {
        ratingList.add(true);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(bookItem.name),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width - 50,
                  padding: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFFB5EAD7),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFFFDAC1),
                        borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      children: <Widget>[
                        Text("Author : " + bookItem.author),
                        Divider(),
                        Text("Page :" + bookItem.page.toString()),
                        Divider(),
                        Text("Start Date :" +
                            DateFormat.yMd().format(bookItem.start)),
                        Divider(),
                        Text("Due Date :" +
                            DateFormat.yMd().format(bookItem.dueDate)),
                        Divider(),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ratingList.length,
                            itemBuilder: (ctx, idx) {
                              return InkWell(
                                onTap: () {
                                  print(ratingList[idx]);
                                  setState(() {
                                    if (ratingList[idx])
                                      bookItem.rating++;
                                    else
                                      bookItem.rating--;
                                  });
                                  print(ratingList[idx]);
                                },
                                child: Icon(
                                  ratingList[idx]
                                      ? Icons.star_border
                                      : Icons.star,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height / 3) * 1.5,
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  onChanged: (value) => bookItem.comment = value,
                  initialValue:
                      bookItem.comment == null ? "" : bookItem.comment,
                  decoration: InputDecoration(
                      labelText: "Comments about book",
                      alignLabelWithHint: true),
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  maxLength: 500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
