import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/init/routes/guards/login_guard.dart';
import 'package:desktop/core/init/routes/guards/onboard_guard.dart';
import 'package:desktop/features/main_page/main_page.dart';
import 'package:desktop/features/menu_page/menu_page_view.dart';
import 'package:desktop/features/onboard_page/onboard_page_view.dart';
import 'package:desktop/features/order_page/orders_page_view.dart';
import 'package:desktop/features/settings_page/settings_page_view.dart';
import 'package:desktop/features/sign_in/sign_in_view.dart';
import 'package:desktop/features/tables_page/tables_page_view.dart';
import 'package:desktop/screens/MainPage/payment_screen.dart';

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
          path: "/auth",
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
