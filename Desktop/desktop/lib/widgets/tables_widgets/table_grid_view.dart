import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desktop/viewModel/tables_view_model.dart';

class TableGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TablesScreenViewModel>(context);
    return GridView.builder(
      itemCount: tableData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final table = tableData[index];
        final tableColor = viewModel.getTableColor(table.table);
        final memberCount = viewModel.getMemberCount(table.table);

        return GestureDetector(
          onTap: () {
            viewModel.setSelectedTable(table.table);
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: tableColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(table.table,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4.0),
                Text(
                  'Members: $memberCount',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
