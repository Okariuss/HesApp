import 'package:flutter/material.dart';

enum OrderStatus { PENDING, ACCEPTED, PREPARING, READY, DELIVERED, CANCELED }

class DropdownExample extends StatelessWidget {
  final OrderStatus selectedStatus;
  final ValueChanged<OrderStatus?>? onChanged;

  const DropdownExample({
    Key? key,
    required this.selectedStatus,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<OrderStatus>(
      value: selectedStatus,
      onChanged: onChanged,
      items: OrderStatus.values.map((OrderStatus option) {
        return DropdownMenuItem<OrderStatus>(
          value: option,
          child: Text(getStatusText(option)),
        );
      }).toList(),
    );
  }

  String getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.PENDING:
        return 'PENDING';
      case OrderStatus.ACCEPTED:
        return 'ACCEPTED';
      case OrderStatus.PREPARING:
        return 'PREPARING';
      case OrderStatus.READY:
        return 'READY';
      case OrderStatus.DELIVERED:
        return 'DELIVERED';
      case OrderStatus.CANCELED:
        return 'CANCELED';
      default:
        return '';
    }
  }
}
