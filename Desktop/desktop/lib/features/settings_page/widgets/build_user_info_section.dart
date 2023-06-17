import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:desktop/features/settings_page/widgets/build_text_field.dart';
import 'package:flutter/material.dart';

Widget buildUserInfoSection(
    BuildContext context, SettingsViewModel viewModel, double maxWidth) {
  return Flexible(
    child: Padding(
      padding: Constants.smallPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageItems.userInfo,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            context,
            LanguageItems.username,
            viewModel.staff?.username ?? "",
            maxWidth,
            viewModel.updateUsername,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            context,
            LanguageItems.phone,
            viewModel.staff?.phone ?? "",
            maxWidth,
            viewModel.updatePhone,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            context,
            LanguageItems.userMail,
            viewModel.staff?.email ?? "",
            maxWidth,
            viewModel.updateEmail,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            context,
            LanguageItems.password,
            viewModel.staff?.password ?? "",
            maxWidth,
            viewModel.updatePassword,
          ),
        ],
      ),
    ),
  );
}
