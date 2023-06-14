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
  );
}
