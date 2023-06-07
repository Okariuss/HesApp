import 'package:auto_route/auto_route.dart';
import 'package:desktop/models/member.dart';
import 'package:desktop/models/table.dart';
import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (tableData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Center(
          child: Text('No payment details available.'),
        ),
      );
    }

    double total = 0.0;

    // Calculate the total price for acceptable orders
    for (var table in tableData) {
      if (table.members != null) {
        for (var member in table.members!) {
          if (member.acceptedOrders.isNotEmpty) {
            total += member.acceptedOrders
                .map((order) => order.price * order.numberOfDelivery)
                .reduce((value, element) => value + element);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tableData.length,
                itemBuilder: (context, tableIndex) {
                  final table = tableData[tableIndex];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Table Number: ${table.table}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      if (table.members != null)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: table.members!.length,
                          itemBuilder: (context, memberIndex) {
                            final member = table.members![memberIndex];
                            final acceptedOrders = member.acceptedOrders;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    'Member: ${member.name}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: acceptedOrders
                                        .map(
                                          (order) => ListTile(
                                            title: Text(order.type),
                                            subtitle: Text(
                                              'Price: ${order.price}, Quantity: ${order.numberOfDelivery}',
                                            ),
                                            trailing: ElevatedButton(
                                              onPressed: () {
                                                member.removeOrder(order);
                                              },
                                              child: Text('Pay'),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                              ],
                            );
                          },
                        ),
                    ],
                  );
                },
              ),
            ),
            Text(
              'Total Price: $total',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform the payment operation here
                // You can display a confirmation dialog or navigate to a success screen
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
