import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/utils/util.dart';

import 'package:desktop/viewModel/home_page_view_model.dart';
import 'package:desktop/widgets/custom_tab.dart';
import 'package:desktop/widgets/orders_tab_with_count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  late SettingsViewModel _settingsViewModel;
  late MenuPageViewModel _menuPageViewModel;
  late TablesScreenViewModel _tablePageViewModel;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _settingsViewModel = Provider.of<SettingsViewModel>(context, listen: false);
    _settingsViewModel.fetchStaffDetails();

    _menuPageViewModel = Provider.of<MenuPageViewModel>(context, listen: false);
    _menuPageViewModel.fetchMenuCategories(Me.restaurantId);

    _tablePageViewModel =
        Provider.of<TablesScreenViewModel>(context, listen: false);
    _tablePageViewModel
        .fetchTables(Me.restaurantId)
        .then((value) => _tablePageViewModel.getAllOrderCount());

    // Start the timer to refresh orders every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      _tablePageViewModel
          .fetchTables(Me.restaurantId)
          .then((value) => _tablePageViewModel.getAllOrderCount());
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainPageViewModel(),
      child: Consumer<SettingsViewModel>(
        builder: (context, settingsViewModel, _) {
          return AutoTabsRouter.tabBar(
            routes: const [
              TablesScreenRoute(),
              MenuScreenRoute(),
              OrdersScreenRoute(),
              PaymentScreenRoute(),
            ],
            builder: (context, child, tabController) {
              return SafeArea(
                child: Scaffold(
                  appBar:
                      DefaultAppBar(tabController, context, settingsViewModel),
                  body: child,
                  extendBody: true,
                ),
              );
            },
          );
        },
      ),
    );
  }

  AppBar DefaultAppBar(
    TabController tabController,
    BuildContext context,
    SettingsViewModel settingsViewModel,
  ) {
    return AppBar(
      title: Text(
        settingsViewModel.staff?.restaurantName ?? "",
        style: Theme.of(context)
            .textTheme
            .headlineLarge
            ?.copyWith(color: Constants.buttonTextColor),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabBar(
                controller: tabController,
                indicatorColor: Constants.buttonTextColor,
                tabs: [
                  const CustomTab(text: LanguageItems.tables),
                  const CustomTab(text: LanguageItems.menu),
                  CustomTabCount(
                      orderCount: _tablePageViewModel.allOrders ?? 0,
                      text: LanguageItems.orders),
                  const CustomTab(text: LanguageItems.payments),
                ],
                indicatorPadding: Constants.defaultPadding,
                isScrollable: true,
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.router.push(const SettingsScreenRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
