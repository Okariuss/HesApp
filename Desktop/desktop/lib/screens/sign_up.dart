import 'package:flutter/material.dart';

import '../models/account/user.dart';
import '../services/account.dart';
import 'sign_in.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final RegisterPersonnelModel user = RegisterPersonnelModel();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final restaurantNameController = TextEditingController();
  final locationController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    restaurantNameController.dispose();
    locationController.dispose();
    contactController.dispose();
    super.dispose();
  }

  void _showEditInfo(Future<String> myFuture) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => FutureBuilder<String>(
            future: myFuture,
            builder: (context, AsyncSnapshot<String> snapshot) {
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
                                    builder: ((context) => const LoginPage())));
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.green,
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
                              backgroundColor: Colors.red,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                onChanged: (value) {
                  setState(() {
                    user.username = value;
                  });
                },
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  setState(() {
                    user.email = value;
                  });
                },
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    user.password = value;
                  });
                },
              ),
              TextField(
                controller: restaurantNameController,
                decoration: const InputDecoration(
                  labelText: 'Restaurant Name',
                ),
                onChanged: (value) {
                  setState(() {
                    user.restaurantName = value;
                  });
                },
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                ),
                onChanged: (value) {
                  setState(() {
                    user.restaurantLocation = value;
                  });
                },
              ),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact',
                ),
                onChanged: (value) {
                  setState(() {
                    user.restaurantContact = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _showEditInfo(AccountService.registerPersonnel(
                      user.username,
                      user.password,
                      user.email,
                      user.restaurantName,
                      user.restaurantLocation,
                      user.restaurantContact));
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
