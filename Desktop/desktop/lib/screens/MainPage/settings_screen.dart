import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:desktop/viewModel/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Basic Information',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: 16.0),
                              buildTextField(
                                context,
                                'Restaurant Name',
                                (value) => context
                                    .read<SettingsViewModel>()
                                    .updateRestaurantName(value),
                                maxWidth,
                              ),
                              const SizedBox(height: 16.0),
                              buildTextField(
                                context,
                                'Restaurant Contact',
                                (value) => context
                                    .read<SettingsViewModel>()
                                    .updateRestaurantContact(value),
                                maxWidth,
                              ),
                              const SizedBox(height: 16.0),
                              buildTextField(
                                context,
                                'Restaurant Location',
                                (value) => context
                                    .read<SettingsViewModel>()
                                    .updateRestaurantLocation(value),
                                maxWidth,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Information',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: 16.0),
                              buildTextField(
                                context,
                                'Username',
                                (value) => context
                                    .read<SettingsViewModel>()
                                    .updateUsername(value),
                                maxWidth,
                              ),
                              const SizedBox(height: 16.0),
                              buildTextField(
                                context,
                                'User Email',
                                (value) => context
                                    .read<SettingsViewModel>()
                                    .updateEmail(value),
                                maxWidth,
                              ),
                              const SizedBox(height: 16.0),
                              buildTextField(
                                context,
                                'Password',
                                (value) => context
                                    .read<SettingsViewModel>()
                                    .updatePassword(value),
                                maxWidth,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      'Opening Hours',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 16.0),
                    Consumer<SettingsViewModel>(
                      builder: (context, viewModel, _) => Column(
                        children: settings.openingDays.map((day) {
                          RangeValues selectedTime =
                              settings.openingHours[day] ??
                                  RangeValues(0, 0); // Assuming 24-hour format

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Checkbox(
                                value: settings.openingDays.contains(day),
                                onChanged: (value) {
                                  inspect(value);
                                  if (value != null) {
                                    if (value) {
                                      viewModel.addOpeningDay(day);
                                    } else {
                                      viewModel.updateOpeningHours(
                                          day, const RangeValues(0, 0));
                                    }
                                  }
                                },
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(day +
                                        (" (${formatTime(selectedTime.start)} - ${formatTime(selectedTime.end)})")),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width) *
                                                0.95, // Set maxWidth constraint
                                            child: RangeSlider(
                                              values: selectedTime,
                                              min: 0,
                                              max:
                                                  1440, // Total minutes in a day (24 * 60)
                                              divisions:
                                                  144, // Each division represents 10 minutes (1440 / 10)
                                              onChanged: (RangeValues values) {
                                                viewModel.updateOpeningHours(
                                                  day,
                                                  RangeValues(
                                                      values.start
                                                          .roundToDouble(),
                                                      values.end
                                                          .roundToDouble()),
                                                );
                                              },
                                              labels: RangeLabels(
                                                formatTime(selectedTime.start),
                                                formatTime(selectedTime.end),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          );
                        }).toList(),
                      ),
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
      ),
    );
  }

  String formatTime(double timeInMinutes) {
    final hours = (timeInMinutes / 60).floor();
    final minutes = (timeInMinutes % 60).floor();
    final formattedHours = hours.toString().padLeft(2, '0');
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes';
  }

  Widget buildTextField(BuildContext context, String labelText,
      Function(String) onChanged, double maxWidth) {
    return SizedBox(
      width: maxWidth < 600 ? double.infinity : maxWidth * 0.5,
      child: Consumer<SettingsViewModel>(
        builder: (context, viewModel, _) => TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
