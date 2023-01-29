import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hesapp_mobile/core/constants/constants.dart';
import 'package:hesapp_mobile/core/constants/language_items.dart';
import 'package:hesapp_mobile/service/signup_service.dart';
import 'package:hesapp_mobile/view/log_in_page.dart';
import 'package:hesapp_mobile/view/main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hiddenPassword = true;
  int _selectedRadio = 0;
  String user_email = "";
  String password = "";
  TextEditingController emailTEC = TextEditingController();
  TextEditingController usernameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();

  void _handleRadioValueChange(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _signupBanner(), //login screen
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  //email
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: Container(
                    width: 300,
                    decoration: _textFieldContainerDecoration(),
                    child: _emailTextField(),
                  ),
                ),
                Padding(
                  //username
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: Container(
                    width: 300,
                    decoration: _textFieldContainerDecoration(),
                    child: _usernameTextField(),
                  ),
                ),
                Padding(
                  //password
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: Container(
                    width: 300,
                    decoration: _textFieldContainerDecoration(),
                    child: _passwordTextField(passwordTEC, "Password"),
                  ),
                ),
                Padding(
                  //password
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: Container(
                    width: 300,
                    decoration: _textFieldContainerDecoration(),
                    child: _passwordTextField(
                        confirmPasswordTEC, "Confirm password"),
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding * 5 / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _signUpButtonContainer(), //login button
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            LanguageItems.logInButtonText,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: primaryColor),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextField _emailTextField() {
    return TextField(
      controller: emailTEC,
      onEditingComplete: () {
        user_email = emailTEC.text;
      },
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: _iconTextField(Icons.mail),
        border: InputBorder.none,
        labelText: "E-mail",
        contentPadding: const EdgeInsets.all(kDefaultPadding / 2),
      ),
    );
  }

  TextField _usernameTextField() {
    return TextField(
      controller: usernameTEC,
      onEditingComplete: () {
        user_email = usernameTEC.text;
      },
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: _iconTextField(Icons.person),
        border: InputBorder.none,
        labelText: "Username",
        contentPadding: const EdgeInsets.all(kDefaultPadding / 2),
      ),
    );
  }

  TextField _passwordTextField(
      TextEditingController textEditingController, String label) {
    return TextField(
      controller: textEditingController,
      onEditingComplete: () {
        password = textEditingController.text;
      },
      obscureText: hiddenPassword,
      decoration: InputDecoration(
        prefixIcon: _iconTextField(Icons.key),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hiddenPassword = !hiddenPassword;
            });
          },
          icon: AnimatedCrossFade(
            firstChild: _iconTextField(Icons.visibility),
            secondChild: _iconTextField(Icons.visibility_off),
            duration: const Duration(seconds: 1),
            crossFadeState: hiddenPassword
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
        border: InputBorder.none,
        labelText: label,
        contentPadding: const EdgeInsets.all(kDefaultPadding / 2),
      ),
    );
  }

  Container _signUpButtonContainer() {
    return Container(
        width: 300,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [_boxShadow()],
        ),
        child: ElevatedButton(
            onPressed: () async {
              if(emailTEC.text.isNotEmpty || usernameTEC.text.isNotEmpty || passwordTEC.text.isNotEmpty) {
               _showEditInfo(SignUpService.register(emailTEC.text, usernameTEC.text, passwordTEC.text));
              }
            },
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            child: const Text(
              "Kayıt ol",
            )));
  }

  Icon _iconTextField(IconData iconData) {
    return Icon(
      iconData,
      color: primaryColor,
    );
  }

  BoxDecoration _textFieldContainerDecoration() {
    return BoxDecoration(
        boxShadow: [
          _boxShadow(),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)));
  }

  BoxShadow _boxShadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 2),
    );
  }

  Container _signupBanner() {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 5,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
      child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
          child: DefaultTextStyle(
            style: GoogleFonts.dancingScript(
              fontSize: 50.0,
              wordSpacing: 2,
              letterSpacing: 2,
              color: Colors.white,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText("Kayıt Ol",
                    textAlign: TextAlign.center,
                    speed: const Duration(milliseconds: 100)),
              ],
              isRepeatingAnimation: true,
              pause: const Duration(milliseconds: 5000),
            ),
          )),
    );
  }

  void _showEditInfo(Future<String> myFuture) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => FutureBuilder<String>(
            future: myFuture,
            builder: (context, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasData) {
                return SimpleDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  title: const Center(child: Text("Başarıyla Kayıt Olundu")),
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const LogInPage())));
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: const Center(child: Text("Anasayfa"))),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return SimpleDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  title: const Center(child: Text("Hata")),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: const Center(child: Text("Tamam"))),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const SimpleDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Center(child: CircularProgressIndicator()),
                );
              }
            }));
  }
}
