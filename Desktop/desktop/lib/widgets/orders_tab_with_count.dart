import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/widgets/custom_tab.dart';
import 'package:flutter/material.dart';

class CustomTabCount extends StatelessWidget {
  const CustomTabCount({
    super.key,
    required this.orderCount,
  });

  final ValueNotifier<int> orderCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTab(text: 'Orders'),
        ValueListenableBuilder<int>(
          valueListenable: orderCount,
          builder: (context, value, _) {
            if (value == 0) {
              return Container(); // Hide the count when it is zero
            }
            return Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: Constants.contentPadding,
                decoration: BoxDecoration(
                  color: Constants.buttonTextColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                    color: Constants.primaryColor,
                    fontSize: Constants.contentSize,
                    fontWeight: Constants.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}