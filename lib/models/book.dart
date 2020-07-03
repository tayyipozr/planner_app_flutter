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
    this.id,
    this.name,
    this.author,
    this.page,
    this.start,
    this.dueDate,
    this.rating,
    this.isRead,
    this.comment,
  });
}
