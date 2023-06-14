import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/enums/local_keys_enum.dart';
import 'package:desktop/core/init/cache/local_manager.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        LocalManager.instance.setBoolValue(
          PreferencesKeys.IS_LOGGED_IN,
          false,
        );
        navigateToLoginPage(context);
      },
      icon: const Icon(Icons.logout_outlined),
    );
  }

  void navigateToLoginPage(BuildContext context) {
    context.router.popUntilRoot();
    context.router.replace(const LoginPageViewRoute());
  }
}
