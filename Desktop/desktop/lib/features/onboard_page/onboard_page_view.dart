import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/core/init/routes/app_router.dart';
import 'package:desktop/core/theme/theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardPageView extends StatelessWidget {
  const OnboardPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    LanguageItems.welcomeText,
                    style: TextStyle(
                        fontWeight: Constants.bold,
                        fontSize: Constants.titleSize),
                  ),
                  Constants.kdefaultSizedBoxSize,
                  const Text(
                    LanguageItems.welcomeDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: Constants.contentSize),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(LanguageItems.welcomeImage))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.router.replace(const LoginPageViewRoute());
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const LoginPageView(),
                        //   ),
                        // );
                      },
                      child: const Text(
                        LanguageItems.login,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
