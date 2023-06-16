class TableModel {
  final int id;
  final int restaurantId;
  final String name;

  TableModel({
    required this.id,
    required this.restaurantId,
    required this.name,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      name: json['name'],
    );
  }
}
