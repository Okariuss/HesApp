import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/enums/local_keys_enum.dart';
import 'package:desktop/core/init/cache/local_manager.dart';

class LoginGuard extends AutoRouteGuard {
  LocalManager localManager = LocalManager.instance;
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    bool isLoggedIn = localManager.getBoolValue(PreferencesKeys.IS_LOGGED_IN);
    if (isLoggedIn) {
      router.replaceNamed("/main");
    } else {
      resolver.next();
    }
  }
}
