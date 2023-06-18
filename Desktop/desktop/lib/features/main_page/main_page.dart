import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:desktop/utils/util.dart';

import 'package:desktop/viewModel/home_page_view_model.dart';
import 'package:desktop/viewModel/orders_view_model.dart';
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
  ValueNotifier<int> orderCount = ValueNotifier<int>(0);

  late OrdersViewModel _ordersViewModel;
  late SettingsViewModel _settingsViewModel;
  late MenuPageViewModel _menuPageViewModel;
  late TablesScreenViewModel _tablePageViewModel;

  @override
  void initState() {
    super.initState();
    _ordersViewModel = Provider.of<OrdersViewModel>(context, listen: false);
    _ordersViewModel.addListener(_updateOrderCount);

    _settingsViewModel = Provider.of<SettingsViewModel>(context, listen: false);
    _settingsViewModel.fetchStaffDetails();

    _menuPageViewModel = Provider.of<MenuPageViewModel>(context, listen: false);
    _menuPageViewModel.fetchMenuCategories(Me.restaurantId);

    _tablePageViewModel =
        Provider.of<TablesScreenViewModel>(context, listen: false);
    _tablePageViewModel.fetchTables(Me.restaurantId);

    _updateOrderCount();
  }

  @override
  void dispose() {
    _ordersViewModel.removeListener(_updateOrderCount);
    super.dispose();
  }

  void _updateOrderCount() {
    setState(() {
      orderCount.value = _ordersViewModel.orders
          .where((member) => member.deliveries.isNotEmpty)
          .length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainPageViewModel(),
      child: Consumer<SettingsViewModel>(
        builder: (context, settingsViewModel, _) {
          _tablePageViewModel.fetchTables(Me.restaurantId);

          return AutoTabsRouter.tabBar(
            routes: const [
              TablesScreenRoute(),
              MenuScreenRoute(),
              OrdersScreenRoute(),
              PaymentScreenRoute(),
            ],
            builder: (context, child, tabController) {
              tabController.addListener(
                () {
                  final activeIndex = tabController.index;
                  // Perform actions based on the active tab index
                  switch (activeIndex) {
                    case 0:
                      // Do something when the TablesScreenRoute tab is active
                      _tablePageViewModel.fetchTables(Me.restaurantId);
                      break;
                    case 1:
                      // Do something when the MenuScreenRoute tab is active
                      _menuPageViewModel.fetchMenuCategories(Me.restaurantId);
                      break;
                    case 2:
                      // Do something when the OrdersScreenRoute tab is active
                      break;
                    case 3:
                      // Do something when the PaymentScreenRoute tab is active
                      break;
                    default:
                      _settingsViewModel.fetchStaffDetails();
                      break;
                  }
                },
              );
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
                      orderCount: orderCount, text: LanguageItems.orders),
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
