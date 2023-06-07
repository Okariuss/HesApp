import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/init/routes/guards/login_guard.dart';
import 'package:desktop/core/init/routes/guards/onboard_guard.dart';
import 'package:desktop/features/main_page/main_page.dart';
import 'package:desktop/features/onboard_page/onboard_page_view.dart';
import 'package:desktop/features/sign_in/sign_in_view.dart';
import 'package:desktop/screens/MainPage/menu_screen.dart';
import 'package:desktop/screens/MainPage/orders_screen.dart';
import 'package:desktop/screens/MainPage/payment_screen.dart';
import 'package:desktop/screens/MainPage/settings_screen.dart';
import 'package:desktop/screens/MainPage/tables_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  List<AutoRoute> get routes => [
        //Onboard
        AutoRoute(
          page: OnboardPageViewRoute.page,
          path: "/onboard",
          initial: true,
          guards: [OnBoardGuard()],
        ),

        //Auth
        AutoRoute(
          page: LoginPageViewRoute.page,
          path: "/login",
          guards: [LoginGuard()],
        ),

        //MainPage
        AutoRoute(
          page: MainPageViewRoute.page,
          path: "/main",
          children: [
            AutoRoute(
              page: TablesScreenRoute.page,
              path: "tables",
              initial: true,
            ),
            AutoRoute(
              page: MenuScreenRoute.page,
              path: "menu",
            ),
            AutoRoute(
              page: OrdersScreenRoute.page,
              path: "orders",
            ),
            AutoRoute(
              page: PaymentScreenRoute.page,
              path: "payment",
            ),
          ],
        ),

        //Settings
        AutoRoute(
          page: SettingsScreenRoute.page,
          path: "/settings",
        )
      ];
}
