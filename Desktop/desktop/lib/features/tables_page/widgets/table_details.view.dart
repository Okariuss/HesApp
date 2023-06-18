import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/features/tables_page/widgets/remove_table_dialog.dart';
import 'package:desktop/features/tables_page/widgets/rename_table_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableDetailsView extends StatelessWidget {
  const TableDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final members = viewModel.getMembersAtTable(tableName);
    // if (members.isNotEmpty) {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       MemberDeliveriesListView(members: members.cast<Member>()),
    //       Constants.kdefaultSizedBoxSize,
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           SizedBox(
    //             width: MediaQuery.of(context).size.height / 4,
    //             child: ElevatedButton.icon(
    //                 onPressed: () {
    //                   viewModel.renameTableDialog(
    //                       context,
    //                       tableName,
    //                       (newName) =>
    //                           viewModel.renameTable(tableName, newName));
    //                 },
    //                 icon: const Icon(Icons.edit),
    //                 label: const Text(LanguageItems.rename)),
    //           ),
    //           SizedBox(
    //             width: MediaQuery.of(context).size.height / 4,
    //             child: ElevatedButton.icon(
    //               onPressed: () {},
    //               icon: const Icon(Icons.delete),
    //               label: const Text(LanguageItems.remove),
    //               style: ButtonStyle(
    //                   backgroundColor:
    //                       MaterialStateProperty.all(Constants.errorColor)),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Constants.kdefaultSizedBoxSize,
    //       ElevatedButton.icon(
    //         onPressed: () {
    //           viewModel.moveSelectedMembersToTableDialog(context, tableName);
    //         },
    //         icon: const Icon(Icons.arrow_forward),
    //         label: const Text(LanguageItems.moveSelectedMembers),
    //       ),
    //       Constants.ksmallSizedBoxSize,
    //       ElevatedButton.icon(
    //         onPressed: () {
    //           viewModel.moveMembersToTableDialog(
    //             context,
    //             tableName,
    //             (newTableName) {},
    //           );
    //         },
    //         icon: const Icon(Icons.move_to_inbox),
    //         label: const Text(LanguageItems.moveAllMembers),
    //       ),
    //     ],
    //   );
    // }
    // else {
    return Consumer<TablesScreenViewModel>(
      builder: (context, viewModel, _) {
        final selectedTable = viewModel.selectedTable;

        if (selectedTable == null) {
          return const Center(
            child: Text(
              LanguageItems.selectTable,
              style: TextStyle(color: Constants.primaryColor),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selectedTable.name,
              style: TextStyle(color: Constants.primaryColor),
            ),
            Constants.kbigSizedBoxSize,
            const Text(
              LanguageItems.noMember,
              style: TextStyle(color: Constants.primaryColor),
            ),
            Constants.kbigSizedBoxSize,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.height / 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => RenameTableDialog(table: selectedTable),
                      ).then((newName) {
                        if (newName != null) {
                          viewModel.updateTable(selectedTable.id, newName);
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(LanguageItems.rename),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height / 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            RemoveTableDialog(tableName: selectedTable),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text(LanguageItems.remove),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Constants.errorColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ); // Return an empty SizedBox if there are no members
    // }
  }
}
