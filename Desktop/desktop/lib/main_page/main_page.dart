import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/screens/MainPage/menu_screen.dart';
import 'package:desktop/screens/MainPage/orders_screen.dart';
import 'package:desktop/screens/MainPage/payment_screen.dart';
import 'package:desktop/screens/MainPage/settings_screen.dart';
import 'package:desktop/screens/MainPage/tables_screen.dart';
import 'package:desktop/viewModel/home_page_view_model.dart';
import 'package:desktop/viewModel/orders_view_model.dart';
import 'package:desktop/widgets/custom_tab.dart';
import 'package:desktop/widgets/orders_tab_with_count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Restaurant Name",
              style: TextStyle(
                fontWeight: Constants.bold,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabBar(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              TablesScreen(),
              MenuScreen(),
              OrdersScreen(),
              PaymentScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
