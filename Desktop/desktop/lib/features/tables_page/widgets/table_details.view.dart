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

        if (selectedTable.users!.isNotEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  selectedTable.name,
                  style: const TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: Constants.bold,
                  ),
                ),
              ),
              Constants.ksmallSizedBoxSize,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 4,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              RenameTableDialog(table: selectedTable),
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
              const Divider(
                height: 30,
                color: Constants.buttonTextColor,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedTable.users!.length,
                  itemBuilder: (context, index) {
                    final user = selectedTable.users![index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '${user.username}\'s deliveries:',
                            style:
                                const TextStyle(color: Constants.primaryColor),
                          ),
                        ),
                        Constants.ktooSmallSizedBoxSize,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: user.orders!.map(
                            (order) {
                              return Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: order.orderItems!.map(
                                      (item) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '- ${item.menuItemName}',
                                                  style: const TextStyle(
                                                      color: Constants
                                                          .primaryColor),
                                                ),
                                                Text(
                                                  '(${item.quantity} x ${item.price} TL)',
                                                  style: const TextStyle(
                                                      color: Constants
                                                          .primaryColor),
                                                ),
                                              ],
                                            ),
                                            Constants.ktooSmallSizedBoxSize,
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Total: ${order.totalAmount} TL',
                                      style: TextStyle(
                                          color: Constants.primaryColor,
                                          fontWeight: Constants.bold),
                                    ),
                                  ),
                                  const Divider(
                                    height: 30,
                                    color: Constants.buttonTextColor,
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                selectedTable.name,
                style: const TextStyle(
                    color: Constants.primaryColor, fontWeight: Constants.bold),
              ),
              Constants.ksmallSizedBoxSize,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 4,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              RenameTableDialog(table: selectedTable),
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
                        ).then((value) => viewModel.setSelectedTable(null));
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
              Constants.kbigSizedBoxSize,
              const Text(
                LanguageItems.noMember,
                style: TextStyle(
                    color: Constants.primaryColor, fontWeight: Constants.bold),
              ),
            ],
          );
        }
      },
    );
  }
}
