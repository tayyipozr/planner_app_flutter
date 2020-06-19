import 'package:flutter/material.dart';

class BookItem {
  final String id;
  final String name;
  final String author;
  final int page;
  final DateTime start;
  final DateTime dueDate;
  int rating;
  bool isRead; 
  String comment;

  BookItem({
    @required this.id,
    @required this.name,
    @required this.author,
    @required this.page,
    @required this.start,
    @required this.dueDate,
    this.rating,
    this.isRead,
    this.comment,
  });
}
