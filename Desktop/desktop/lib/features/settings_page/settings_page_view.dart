import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/enums/local_keys_enum.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/core/init/cache/local_manager.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(LanguageItems.settings),
        actions: const [LogoutButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.bigPadding,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: Constants.smallPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LanguageItems.basicInfo,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.restaurantName,
                                viewModel.staff?.restaurantName ?? "",
                                viewModel.updateRestaurantName,
                                maxWidth,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.restaurantContact,
                                viewModel.staff?.restaurantPhone ?? "",
                                viewModel.updateRestaurantContact,
                                maxWidth,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.restaurantLocation,
                                viewModel.staff?.restaurantAddress ?? "",
                                viewModel.updateRestaurantLocation,
                                maxWidth,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.restaurantDescription,
                                viewModel.staff?.restaurantDescription ?? "",
                                viewModel.updateDescription,
                                maxWidth,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Constants.ksmallSizedBoxSize,
                      Flexible(
                        child: Padding(
                          padding: Constants.smallPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LanguageItems.userInfo,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.username,
                                viewModel.staff?.username ?? "",
                                viewModel.updateUsername,
                                maxWidth,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.phone,
                                viewModel.staff?.phone ?? "",
                                viewModel.updatePhone,
                                maxWidth,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.userMail,
                                viewModel.staff?.email ?? "",
                                viewModel.updateEmail,
                                maxWidth,
                              ),
                              Constants.ksmallSizedBoxSize,
                              buildTextField(
                                context,
                                LanguageItems.password,
                                viewModel.staff?.password ?? "",
                                viewModel.updatePassword,
                                maxWidth,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          final viewModel =
              Provider.of<SettingsViewModel>(context, listen: false);
          viewModel.saveSettings();
        },
      ),
    );
  }

  Widget buildTextField(BuildContext context, String labelText, String text,
      Function(String) onChanged, double maxWidth) {
    return SizedBox(
      width: maxWidth < 600 ? double.infinity : maxWidth * 0.5,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        initialValue: text,
        onChanged: onChanged,
      ),
    );
  }
}

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
        context.router.popUntilRoot();
        context.router.replace(const LoginPageViewRoute());
      },
      icon: const Icon(Icons.logout_outlined),
    );
  }
}
