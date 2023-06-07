import 'package:desktop/core/init/cache/local_manager.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:desktop/core/theme/theme.dart';
import 'package:desktop/viewModel/orders_view_model.dart';
import 'package:desktop/viewModel/settings_view_model.dart';
import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewModel/menu_view_model.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MenuViewModel()),
    ChangeNotifierProvider(create: (context) => TablesScreenViewModel()),
    ChangeNotifierProvider(create: (context) => SettingsViewModel()),
    ChangeNotifierProvider(create: (context) => OrdersViewModel())
  ], child: MainWidget()));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalManager.preferencesInit();
}

class MainWidget extends StatelessWidget {
  final _appRouter = AppRouter();
  MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _appRouter.routeInfoProvider(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
    );
  }
}
