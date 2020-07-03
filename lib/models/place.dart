class PlaceItem {
  final String id;
  final String name;
  final int belong;
  bool visited;

  PlaceItem({
    this.id,
    this.belong,
    this.name,
    this.visited = false,
  });
}
