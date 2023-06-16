import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/widgets/custom_tab.dart';
import 'package:flutter/material.dart';

class CustomTabCount extends StatelessWidget {
  const CustomTabCount({
    Key? key,
    required this.orderCount,
    required this.text,
  }) : super(key: key);

  final ValueNotifier<int> orderCount;
  final String text;

  @override
  Widget build(BuildContext context) {
    final circleSize = MediaQuery.of(context).size.width * 0.02;

    return SizedBox(
      height: MediaQuery.of(context).size.width / 25,
      width: MediaQuery.of(context).size.width / 8,
      child: Stack(
        children: [
          CustomTab(text: text),
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
                  width: circleSize,
                  height: circleSize,
                  decoration: const BoxDecoration(
                    color: Constants.buttonTextColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      value.toString(),
                      style: const TextStyle(
                        color: Constants.primaryColor,
                        fontSize: Constants.contentSize,
                        fontWeight: Constants.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
