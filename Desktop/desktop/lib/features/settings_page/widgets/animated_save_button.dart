import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/settings_page/settings_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedSaveButton extends StatefulWidget {
  const AnimatedSaveButton({Key? key}) : super(key: key);

  @override
  _AnimatedSaveButtonState createState() => _AnimatedSaveButtonState();
}

class _AnimatedSaveButtonState extends State<AnimatedSaveButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      onTap: () {
        viewModel.saveSettings().then((success) {
          if (success) {
            _showSaveDialog(context);
          }
        });
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: FloatingActionButton(
              onPressed: null,
              child: Constants
                  .saveIcon, // Set to null to disable the button temporarily
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _showSaveDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(LanguageItems.success),
        content: const Text(LanguageItems.settingsSaved),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              LanguageItems.ok,
              style: TextStyle(color: Constants.buttonTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
