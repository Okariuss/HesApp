import 'package:desktop/models/member.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Member member;
  final Function(int) acceptOrderCallback; // Updated callback function
  final Function(int) removeOrderCallback; // Updated callback function

  OrderDetailsScreen({
    required this.member,
    required this.acceptOrderCallback,
    required this.removeOrderCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: Text(member.name),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Table Number: ${member.table}'),
                SizedBox(height: 16.0),
                Text(
                  'Deliveries:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: member.deliveries.length,
                  itemBuilder: (context, selectedIndex) {
                    final delivery = member.deliveries[selectedIndex];
                    return ListTile(
                      title: Text(delivery.type),
                      subtitle: Text(
                        'Price: ${delivery.price}, Quantity: ${delivery.numberOfDelivery}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () => acceptOrderCallback(
                                selectedIndex), // Pass the selectedIndex
                            child: Text('Accept Order'),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          ElevatedButton(
                            onPressed: () => removeOrderCallback(
                                selectedIndex), // Pass the selectedIndex
                            child: Text('Remove Order'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
