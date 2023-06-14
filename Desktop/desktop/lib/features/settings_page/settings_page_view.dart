import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/build_basic_info_section.dart';
import 'widgets/build_user_info_section.dart';
import 'widgets/logout_button.dart';

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
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBasicInfoSection(context, viewModel, maxWidth),
                  Constants.ksmallSizedBoxSize,
                  buildUserInfoSection(context, viewModel, maxWidth),
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
}
