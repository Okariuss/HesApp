import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/features/tables_page/widgets/add_table_dialog.dart';
import 'package:desktop/features/tables_page/widgets/table_details.view.dart';
import 'package:desktop/features/tables_page/widgets/table_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tables_page_view_model.dart';

@RoutePage()
class TablesScreen extends StatelessWidget {
  const TablesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            flex: 2,
            child: TableGridView(),
          ),
          Expanded(
            flex: 1,
            child: Container(
                height: screenSize.height,
                color: Constants.tableDetailsColor,
                child: const TableDetailsView()),
          ),
        ],
      ),
      floatingActionButton: const TableFloatingActionButton(),
    );
  }
}

class TableFloatingActionButton extends StatelessWidget {
  const TableFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AddTableDialog(),
        );
      },
    );
  }
}
