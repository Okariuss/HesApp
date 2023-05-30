import 'package:desktop/models/delivery.dart';

class Member {
  String name;
  String table;
  List<Delivery> deliveries;
  List<Delivery> acceptedOrders;

  Member({
    required this.name,
    required this.table,
    List<Delivery>? deliveries,
    List<Delivery>? acceptedOrders,
  })  : deliveries = deliveries ?? [],
        acceptedOrders = acceptedOrders ?? [];

  double get totalPrice {
    return acceptedOrders
        .map((order) => order.price * order.numberOfDelivery)
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  void acceptOrder(Delivery order) {
    acceptedOrders.add(order);
  }

  void removeOrder(Delivery order) {
    acceptedOrders.remove(order);
  }
}
