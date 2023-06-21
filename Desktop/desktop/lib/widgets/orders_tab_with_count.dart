import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/widgets/custom_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTabCount extends StatelessWidget {
  const CustomTabCount({
    Key? key,
    required this.orderCount,
    required this.text,
  }) : super(key: key);

  final int orderCount;
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
          Positioned(
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
                  orderCount.toString(),
                  style: const TextStyle(
                    color: Constants.primaryColor,
                    fontSize: Constants.contentSize,
                    fontWeight: Constants.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
