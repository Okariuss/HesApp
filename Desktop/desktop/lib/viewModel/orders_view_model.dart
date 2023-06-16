import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/models/delivery.dart';
import 'package:desktop/models/member.dart';
import 'package:desktop/models/table.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends ChangeNotifier {
  List<Member> get orders {
    List<Member> allMembers = [];
    // for (var table in tableData) {
    //   if (table.members != null) {
    //     allMembers.addAll(table.members!);
    //   }
    // }
    return allMembers;
  }

  int get orderCount => orders.length;

  void acceptOrder(Member member, Delivery delivery) {
    // Remove accepted orders from the member's deliveries
    member.deliveries.remove(delivery);
    member.acceptedOrders.add(delivery);
    notifyOrderCount();
    notifyListeners();
  }

  void removeOrder(Member member, Delivery delivery) {
    member.deliveries.remove(delivery);
    notifyOrderCount();
    notifyListeners();
  }

  void moveOrderToTable(Member member, String targetTable) {
    // final sourceTable =
    //     tableData.firstWhere((table) => table.table == member.table);
    // final targetTableData =
    //     tableData.firstWhere((table) => table.table == targetTable);
    // if (targetTableData != null) {
    //   targetTableData.members ??= [];
    //   targetTableData.members!.add(member);
    // } else {
    //   tableData.add(Tables(table: targetTable, members: <Member>[member]));
    // }

    // sourceTable.members?.remove(member);
    // member.table = targetTable;
    notifyListeners();
  }

  void notifyOrderCount() {
    notifyListeners();
  }
}
