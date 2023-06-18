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
            labelText: LanguageItems.username,
            text: viewModel.staff?.username ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updateUsername,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            labelText: LanguageItems.phone,
            text: viewModel.staff?.phone ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updatePhone,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            labelText: LanguageItems.userMail,
            text: viewModel.staff?.email ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updateEmail,
            enabled: false,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            labelText: LanguageItems.password,
            text: viewModel.staff?.password ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updatePassword,
          ),
        ],
      ),
    ),
  );
}
