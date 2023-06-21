import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
import 'package:desktop/features/order_page/dropdown.dart';
import 'package:desktop/features/order_page/orders_page_model.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late TablesScreenViewModel model;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      model = Provider.of<TablesScreenViewModel>(context, listen: false);
      model.fetchTables(Me.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TablesScreenViewModel>(
      builder: (context, tablesViewModel, _) {
        final tables = tablesViewModel.tables;

        if (tables.isEmpty) {
          return const Center(
            child: Text(
              'No tables available.',
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          itemCount: tables.length,
          itemBuilder: (context, tableIndex) {
            final table = tables[tableIndex];
            final users = table.users;

            if (users == null || users.isEmpty) {
              return const SizedBox.shrink(); // Skip tables with no users
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final user in users)
                  if (user.orders != null && user.orders!.isNotEmpty)
                    for (final order in user.orders!)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => OrderDialog(
                              order: order,
                              tableName: table.name,
                              username: user.username!,
                              onStatusChanged: (newStatus) async {
                                tablesViewModel.updateOrderStatus(
                                  order.id!,
                                  newStatus,
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2.0,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            title: Text(
                              '${table.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Text(
                              '${user.username}\nTotal Price: ${order.totalAmount} TL',
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${order.status}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            );
          },
        );
      },
    );
  }
}

class OrderDialog extends StatefulWidget {
  final OrderModel order;
  final String tableName;
  final String username;
  final Function(String) onStatusChanged;

  const OrderDialog({
    Key? key,
    required this.order,
    required this.tableName,
    required this.username,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  _OrderDialogState createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  OrderStatus selectedStatus = OrderStatus.PENDING;

  @override
  void initState() {
    super.initState();
    selectedStatus = getOrderStatusFromString(widget.order.status!);
  }

  @override
  Widget build(BuildContext context) {
    final tablesViewModel = Provider.of<TablesScreenViewModel>(context);

    return AlertDialog(
      title: const Text('Order Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.tableName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.username}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownExample(
                selectedStatus: selectedStatus,
                onChanged: (status) {
                  setState(() {
                    selectedStatus = status!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          Column(
            children: [
              for (final orderss in widget.order.orderItems!)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' - ${orderss.menuItemName!}'),
                    Text('${orderss.quantity!} x ${orderss.price}'),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total Price: ${widget.order.totalAmount} TL',
            ),
          ),
          // Add more details here as needed
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                LanguageItems.cancel,
                style: TextStyle(color: Constants.errorColor),
              ),
            ),
            TextButton(
              onPressed: () {
                final newStatus = getStatusString(selectedStatus);
                widget.onStatusChanged(newStatus);
                tablesViewModel.updateOrderStatus(widget.order.id!, newStatus);
                Navigator.of(context).pop();
              },
              child: const Text(
                LanguageItems.save,
                style: TextStyle(color: Constants.buttonTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getStatusString(OrderStatus status) {
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

  OrderStatus getOrderStatusFromString(String status) {
    switch (status) {
      case 'PENDING':
        return OrderStatus.PENDING;
      case 'ACCEPTED':
        return OrderStatus.ACCEPTED;
      case 'PREPARING':
        return OrderStatus.PREPARING;
      case 'READY':
        return OrderStatus.READY;
      case 'DELIVERED':
        return OrderStatus.DELIVERED;
      case 'CANCELED':
        return OrderStatus.CANCELED;
      default:
        return OrderStatus.PENDING;
    }
  }
}
