import 'package:desktop/core/theme/theme.dart';
import 'package:desktop/main_page/main_page.dart';
import 'package:desktop/sign_in/sign_in_view.dart';
import 'package:desktop/viewModel/orders_view_model.dart';
import 'package:desktop/viewModel/settings_view_model.dart';
import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:desktop/welcome_page/welcome_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewModel/menu_view_model.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MenuViewModel()),
    ChangeNotifierProvider(create: (context) => TablesScreenViewModel()),
    ChangeNotifierProvider(create: (context) => SettingsViewModel()),
    ChangeNotifierProvider(create: (context) => OrdersViewModel())
  ], child: const MainWidget()));
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const WelcomePage(),
    );
  }
}
