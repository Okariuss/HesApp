import 'package:flutter/material.dart';

class MainPageViewModel extends ChangeNotifier {
  int _orderCount = 0;

  ValueNotifier<int> orderCountNotifier = ValueNotifier<int>(0);

  int get orderCount => _orderCount;

  void updateOrderCount(int count) {
    _orderCount = count;
    orderCountNotifier.value = count;
  }
}
