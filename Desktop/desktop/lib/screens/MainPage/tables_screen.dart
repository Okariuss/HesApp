import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:desktop/widgets/tables_widgets/add_table_dialog.dart';
import 'package:desktop/widgets/tables_widgets/table_details.view.dart';
import 'package:desktop/widgets/tables_widgets/table_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<TablesScreenViewModel>(
        builder: (context, tableViewModel, _) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: TableGridView(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: screenSize.height,
                    color: Constants.tableDetailsColor,
                    child: TableDetailsView()),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddTableDialog(),
          );
        },
      ),
    );
  }
}
