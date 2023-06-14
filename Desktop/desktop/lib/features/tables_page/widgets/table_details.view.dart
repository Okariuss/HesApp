import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/models/member.dart';
import 'package:desktop/features/tables_page/tables_widgets/member_deliveries_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableDetailsView extends StatelessWidget {
  const TableDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TablesScreenViewModel>(context);
    final selectedTable = viewModel.selectedTable;
    final tableName = selectedTable ?? '';

    if (selectedTable == null) {
      return const Text(LanguageItems.selectTable);
    }

    final members = viewModel.getMembersAtTable(tableName);
    if (members.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberDeliveriesListView(members: members.cast<Member>()),
          Constants.kdefaultSizedBoxSize,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height / 4,
                child: ElevatedButton.icon(
                    onPressed: () {
                      viewModel.renameTableDialog(
                          context,
                          tableName,
                          (newName) =>
                              viewModel.renameTable(tableName, newName));
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(LanguageItems.rename)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height / 4,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  label: const Text(LanguageItems.delete),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Constants.errorColor)),
                ),
              ),
            ],
          ),
          Constants.kdefaultSizedBoxSize,
          ElevatedButton.icon(
            onPressed: () {
              viewModel.moveSelectedMembersToTableDialog(context, tableName);
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text(LanguageItems.moveSelectedMembers),
          ),
          Constants.ksmallSizedBoxSize,
          ElevatedButton.icon(
            onPressed: () {
              viewModel.moveMembersToTableDialog(
                context,
                tableName,
                (newTableName) {},
              );
            },
            icon: const Icon(Icons.move_to_inbox),
            label: const Text(LanguageItems.moveAllMembers),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Constants.kbigSizedBoxSize,
          const Text(LanguageItems.noMember),
          Constants.kbigSizedBoxSize,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height / 4,
                child: ElevatedButton.icon(
                    onPressed: () {
                      viewModel.renameTableDialog(
                          context,
                          tableName,
                          (newName) =>
                              viewModel.renameTable(tableName, newName));
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(LanguageItems.rename)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height / 4,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  label: const Text(LanguageItems.delete),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Constants.errorColor)),
                ),
              ),
            ],
          ),
        ],
      ); // Return an empty SizedBox if there are no members
    }
  }
}
