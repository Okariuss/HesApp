// import 'package:desktop/core/constants/constants.dart';
// import 'package:desktop/core/constants/language_items.dart';
// import 'package:desktop/features/tables_page/tables_page_view_model.dart';
// import 'package:desktop/models/member.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MoveMembersToTableDialog extends StatelessWidget {
//   final String title;
//   final String sourceTable;
//   final List<Member> memberList;
//   final void Function(String?) onTableSelected; // Updated parameter type

//   const MoveMembersToTableDialog({
//     Key? key,
//     required this.title,
//     required this.sourceTable,
//     required this.memberList,
//     required this.onTableSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TablesScreenViewModel>(context);
//     final availableTables = tableData
//         .where((tableData) => tableData.table != sourceTable)
//         .map((tableData) => tableData.table)
//         .toList();
//     String? selectedTable =
//         availableTables.isNotEmpty ? availableTables[0] : null;
//     return AlertDialog(
//       title: Text(title),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Move members from "$sourceTable" to:'),
//           const SizedBox(height: 16),
//           DropdownButton<String>(
//             value: selectedTable,
//             onChanged: onTableSelected,
//             items: availableTables.map((tableName) {
//               return DropdownMenuItem<String>(
//                 value: tableName,
//                 child: Text(tableName),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 16,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(Constants.errorColor)),
//                 child: const Text(LanguageItems.cancel),
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 16,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (selectedTable != null) {
//                     provider.moveMembersToTable(
//                         memberList, sourceTable, selectedTable);
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: const Text(LanguageItems.ok),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
