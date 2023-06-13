import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/enums/local_keys_enum.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/core/init/cache/local_manager.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:desktop/features/sign_in/sign_in_service.dart';
import 'package:desktop/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:desktop/utils/util.dart';

@RoutePage()
class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHeader(),
            _buildFormFields(),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Padding _buildLoginButton() {
    return Padding(
      padding: Constants.defaultPadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Constants.bigBorderRadius,
        ),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 60,
          onPressed: () {
            _showEditInfo(
              SignInService.authenticate(Me.mail, Me.password),
            );
          },
          color: Constants.buttonTextColor,
          shape: Constants.defaultRectangleRadius,
          child: const Text(
            LanguageItems.login,
            style: TextStyle(
              fontWeight: Constants.semiBold,
              fontSize: Constants.subtitleSize,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildFormFields() {
    return Padding(
      padding: Constants.bigHorizontalSymmetricPadding,
      child: Column(
        children: [
          CustomTextFormField(
            controller: usernameController,
            cursorColor: Constants.buttonTextColor,
            labelText: LanguageItems.email,
            labelColor: Constants.secondaryColor,
            focusedBorderColor: Constants.buttonTextColor,
            focusNode: _usernameFocusNode,
            onChanged: (value) {
              setState(() {
                Me.setMail(value);
              });
            },
          ),
          Constants.kdefaultSizedBoxSize,
          CustomTextFormField(
            controller: passwordController,
            obscureText: true,
            cursorColor: Constants.buttonTextColor,
            labelText: LanguageItems.password,
            labelColor: Constants.secondaryColor,
            focusedBorderColor: Constants.buttonTextColor,
            focusNode: _passwordFocusNode,
            onChanged: (value) {
              setState(() {
                Me.setPassword(value);
              });
            },
          ),
        ],
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      children: const [
        Text(
          LanguageItems.login,
          style: TextStyle(
            fontSize: Constants.titleSize,
            fontWeight: Constants.bold,
          ),
        ),
        Constants.kdefaultSizedBoxSize,
        Text(
          LanguageItems.welcomeBack,
          style: TextStyle(
            fontSize: Constants.contentSize,
            color: Colors.white,
          ),
        ),
        Constants.kdefaultSizedBoxSize,
      ],
    );
  }

  Future _showEditInfo(Future<String> myFuture) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return FutureBuilder<String>(
          future: myFuture,
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SimpleDialog(
                backgroundColor: Colors.transparent,
                title: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData) {
              Future.delayed(Duration.zero, () async {
                await LocalManager.instance.setBoolValue(
                  PreferencesKeys.IS_FIRST_APP,
                  false,
                );
                await LocalManager.instance.setBoolValue(
                  PreferencesKeys.IS_LOGGED_IN, // New line: Save login status
                  true,
                );
                context.router.replace(const MainPageViewRoute());
              });
              return Container(); // Empty container since we're navigating away
            } else if (snapshot.hasError) {
              return AlertDialog(
                shape: Constants.defaultRectangleRadius,
                title: const Center(child: Text(LanguageItems.error)),
                content: Padding(
                  padding: Constants.titlePadding,
                  child: Text(snapshot.error.toString()),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Constants.errorColor,
                      shape: Constants.defaultRectangleRadius,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: const Center(child: Text(LanguageItems.ok)),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox(); // Placeholder widget
            }
          },
        );
      },
    );
  }
}
