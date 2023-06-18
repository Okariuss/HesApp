import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableGridView extends StatelessWidget {
  const TableGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TablesScreenViewModel>(
      builder: (context, viewModel, child) {
        return GridView.builder(
          itemCount: viewModel.tables.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final table = viewModel.tables[index];
            // final tableColor = viewModel.getTableColor(table.table);
            // final memberCount = viewModel.getMemberCount(table.table);

            return GestureDetector(
              onTap: () {
                viewModel.setSelectedTable(table);
              },
              child: Container(
                margin: Constants.smallPadding,
                decoration: BoxDecoration(
                  // color: tableColor,
                  color: Colors.red,
                  borderRadius: Constants.smallBorderRadius,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(table.name,
                        style: Theme.of(context).textTheme.bodyMedium),
                    // Constants.ksmallSizedBoxSize,
                    // Text(
                    //   '${LanguageItems.members}: $memberCount',
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
