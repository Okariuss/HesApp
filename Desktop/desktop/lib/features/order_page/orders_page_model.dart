import 'dart:convert';

class OrderModel {
  int? id;
  int? userId;
  int? restaurantId;
  int? tableId;
  String? status;
  double? totalAmount;
  DateTime? orderTime;
  dynamic deliveryTime;
  List<OrderItemModel>? orderItems;
  List<dynamic>? paymentTransactions;

  OrderModel({
    this.id,
    this.userId,
    this.restaurantId,
    this.tableId,
    this.status,
    this.totalAmount,
    this.orderTime,
    this.deliveryTime,
    this.orderItems,
    this.paymentTransactions,
  });

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
        tableId: json["table_id"],
        status: json["status"],
        totalAmount: json["total_amount"]?.toDouble(),
        orderTime: json["order_time"] == null
            ? null
            : DateTime.parse(json["order_time"]),
        deliveryTime: json["delivery_time"],
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItemModel>.from(
                json["order_items"]!.map((x) => OrderItemModel.fromJson(x))),
        paymentTransactions: json["payment_transactions"] == null
            ? []
            : List<dynamic>.from(json["payment_transactions"]!.map((x) => x)),
      );
}

class OrderItemModel {
  int? orderId;
  int? menuItemId;
  String? menuItemName;
  int? quantity;
  double? price;

  OrderItemModel({
    this.orderId,
    this.menuItemId,
    this.menuItemName,
    this.quantity,
    this.price,
  });

  factory OrderItemModel.fromRawJson(String str) =>
      OrderItemModel.fromJson(json.decode(str));

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        orderId: json["order_id"],
        menuItemId: json["menu_item_id"],
        menuItemName: json["menu_item_name"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
      );
}
