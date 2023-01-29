
import 'package:flutter/material.dart';
import 'package:hesapp_mobile/util/util.dart';
import 'package:hesapp_mobile/view/profile_page.dart';
import 'package:hesapp_mobile/view/qr_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final double _notcedValue = 10;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => QRPage(),));
          },
          child: const Icon(Icons.qr_code),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: _notcedValue,
          color: Colors.blue,
          child: _MyTabView(),
        ),
        body: _TabBarView(),
      ),
    );
  }

  TabBar _MyTabView() {
    return TabBar(
        padding: EdgeInsets.zero,
        onTap: (int index) {},
        tabs: _MyTabViews.values.map((e) => Tab(text: e.name)).toList());
  }

  TabBarView _TabBarView() {
    return TabBarView(children: [
      const ProfilePage(),
      Container(
        color: Colors.blue,
        child: Text("${Me.token}"),
      ),
      Container(
        color: Colors.black,
      ),
      Container(
        color: Colors.green,
      ),
    ]);
  }
}

enum _MyTabViews {
  home,
  settings,
  favorites,
  profile,
}

extension _MyTabViewExtension on _MyTabViews {}
