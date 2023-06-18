import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:desktop/features/settings_page/widgets/build_text_field.dart';
import 'package:flutter/material.dart';

Widget buildBasicInfoSection(
    BuildContext context, SettingsViewModel viewModel, double maxWidth) {
  return Flexible(
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
            labelText: LanguageItems.restaurantName,
            text: viewModel.staff?.restaurantName ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updateRestaurantName,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            labelText: LanguageItems.restaurantContact,
            text: viewModel.staff?.restaurantPhone ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updateRestaurantContact,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            labelText: LanguageItems.restaurantLocation,
            text: viewModel.staff?.restaurantAddress ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updateRestaurantLocation,
          ),
          Constants.ksmallSizedBoxSize,
          buildTextField(
            labelText: LanguageItems.restaurantDescription,
            text: viewModel.staff?.restaurantDescription ?? "",
            maxWidth: maxWidth,
            onChanged: viewModel.updateDescription,
          ),
        ],
      ),
    ),
  );
}
