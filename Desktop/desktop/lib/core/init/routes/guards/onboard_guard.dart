import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/enums/local_keys_enum.dart';
import 'package:desktop/core/init/cache/local_manager.dart';

class OnBoardGuard extends AutoRouteGuard {
  LocalManager localManager = LocalManager.instance;
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    bool isFirst = localManager.getBoolValue(PreferencesKeys.IS_FIRST_APP);
    if (isFirst) {
      resolver.next();
    } else {
      router.replaceNamed("/login");
    }
  }
}
