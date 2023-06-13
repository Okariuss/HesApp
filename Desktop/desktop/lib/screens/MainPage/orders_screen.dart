import 'package:auto_route/auto_route.dart';
import 'package:desktop/screens/MainPage/order_details_screen.dart';
import 'package:desktop/viewModel/orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersViewModel = Provider.of<OrdersViewModel>(context);

    final ordersWithDeliveries = ordersViewModel.orders
        .where((member) => member.deliveries.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersWithDeliveries.length,
        itemBuilder: (context, index) {
          final member = ordersWithDeliveries[index];

          return ListTile(
            title: Text("${member.table} - ${member.name}"),
            subtitle: Text(member.name),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => OrderDetailsScreen(
                  member: member,
                  acceptOrderCallback: (selectedIndex) {
                    ordersViewModel.acceptOrder(
                      member,
                      member.deliveries[selectedIndex],
                    );
                    Navigator.pop(context); // Close the dialog
                  },
                  removeOrderCallback: (selectedIndex) {
                    ordersViewModel.removeOrder(
                      member,
                      member.deliveries[selectedIndex],
                    );
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
