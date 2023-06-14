import 'package:desktop/core/init/cache/local_manager.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:desktop/core/theme/theme.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/utils/util.dart';
import 'package:desktop/viewModel/orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewModel/menu_view_model.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MainApp({super.key});

  Future<void> _initApp(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Me.init();
    await LocalManager.preferencesInit();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initApp(context),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MenuViewModel()),
              ChangeNotifierProvider(
                  create: (context) => TablesScreenViewModel()),
              ChangeNotifierProvider(create: (context) => SettingsViewModel()),
              ChangeNotifierProvider(create: (context) => OrdersViewModel()),
            ],
            child: MainWidget(appRouter: _appRouter),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class MainWidget extends StatelessWidget {
  final AppRouter appRouter;

  const MainWidget({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: appRouter.routeInfoProvider(),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
    );
  }
}
