import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/widgets/book_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../providers/book_providers.dart';
import '../models/book.dart';

class BookDetailScreen extends StatefulWidget {
  static const routeName = "/book-detail";

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  var tempComment;

  @override
  void initState() {
    tempComment = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookId = ModalRoute.of(context).settings.arguments as String;
    final book = Provider.of<Book>(context);
    BookItem bookItem;
    List<BookItem> books = book.items.values.toList();
    books.forEach((book) {
      if (book.id == bookId) {
        bookItem = book;
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (tempComment != "") {
                book.updateItem(BookItem(id: bookId, comment: tempComment));
              }
              Navigator.of(context).pop();
            }),
        title: Text(bookItem.name),
        actions: [
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) => BookBottomSheet(
                        id: bookItem.id,
                        name: bookItem.name,
                        author: bookItem.author,
                        page: bookItem.page,
                        start: bookItem.start,
                        due: bookItem.dueDate,
                        fromEdit: true,
                      ));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<Book>(context, listen: false).removeItem(bookId);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          tempComment = tempComment.trim();
          print("temp :" + tempComment);
          FocusScope.of(context).unfocus();
          if (tempComment != "") {
            book.updateItem(BookItem(id: bookId, comment: tempComment));
          }
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          height: MediaQuery.of(context).size.height / 25,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ratingList.length,
                            itemBuilder: (ctx, idx) {
                              return InkWell(
                                onTap: () {
                                  print(ratingList[idx]);
                                  setState(() {
                                    if (ratingList[idx])
                                      book.updateItem(BookItem(
                                          id: bookId,
                                          rating: ++bookItem.rating));
                                    else
                                      book.updateItem(BookItem(
                                          id: bookId,
                                          rating: --bookItem.rating));
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
                  autofocus: true,
                  onChanged: (value) => tempComment = value,
                  initialValue:
                      bookItem.comment == null ? "" : bookItem.comment,
                  decoration: InputDecoration(
                      labelText: "Comments about book",
                      alignLabelWithHint: true),
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  maxLength: 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
