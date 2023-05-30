import 'package:desktop/models/member.dart';
import 'package:flutter/material.dart';

class MemberDeliveriesListView extends StatelessWidget {
  final List<Member> members;

  const MemberDeliveriesListView({Key? key, required this.members})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var member in members)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${member.name}\'s Accepted Deliveries:'),
              if (member.acceptedOrders.isEmpty)
                const Text('- No accepted deliveries')
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var delivery in member.acceptedOrders)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('- ${delivery.type}'),
                          Text(
                            '(${delivery.numberOfDelivery} x ${delivery.price} TL)',
                          ),
                        ],
                      ),
                  ],
                ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Price: '),
                  Text('${member.totalPrice} TL'),
                ],
              ),
              const Divider(),
            ],
          ),
      ],
    );
  }
}
