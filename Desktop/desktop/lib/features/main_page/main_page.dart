import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/core/init/routes/app_router.dart';

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

  @override
  void initState() {
    super.initState();
    _ordersViewModel = Provider.of<OrdersViewModel>(context, listen: false);
    _ordersViewModel.addListener(_updateOrderCount);

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
      child: AutoTabsRouter.tabBar(
        routes: const [
          TablesScreenRoute(),
          MenuScreenRoute(),
          OrdersScreenRoute(),
          PaymentScreenRoute(),
        ],
        builder: (context, child, tabController) {
          return SafeArea(
            child: Scaffold(
              appBar: DefaultAppBar(tabController, context),
              body: child,
              extendBody: true,
            ),
          );
        },
      ),
    );
  }

  AppBar DefaultAppBar(TabController tabController, BuildContext context) {
    return AppBar(
      title: const Text("Restaurant Name"),
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
                  CustomTab(text: LanguageItems.tables),
                  CustomTab(text: LanguageItems.menu),
                  CustomTabCount(
                      orderCount: orderCount, text: LanguageItems.orders),
                  CustomTab(text: LanguageItems.payments),
                ],
                indicatorPadding: Constants.defaultPadding,
                isScrollable: true,
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  context.router.push(const SettingsScreenRoute());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SettingsScreen(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
