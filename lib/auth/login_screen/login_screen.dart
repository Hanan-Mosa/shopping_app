import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/auth/signup_screen/signup_screen.dart';
import 'package:shopping_app/auth/text_form_field_widget.dart';
import 'package:shopping_app/dialog_utils.dart';
import 'package:shopping_app/main_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "log in";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                controller: emailController,
                labelText: tr('email'),
                type: TextInputType.emailAddress,
                validate: validateEmail,
                hidden: false,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                controller: passwordController,
                labelText: tr('password'),
                type: TextInputType.text,
                validate: validatePassword,
                hidden: true,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      DialogUtils.showLoading(context);
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        if (credential.user != null) {
                          clear();
                          DialogUtils.hideLoading(context);
                          DialogUtils.showMessage(
                              context: context,
                              content: 'Login success ',
                              title: 'Log in',
                              posActionName: 'OK',
                              posAction: () => Navigator.pushReplacementNamed(
                                  context, HomeScreen.routeName));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-credential') {
                          DialogUtils.hideLoading(context);
                          DialogUtils.showMessage(
                              context: context,
                              content: 'No user found for that email. ',
                              title: 'Log in',
                              posActionName: 'OK',
                              posAction: () => Navigator.pop(context));
                        }
                      } catch (e) {
                        DialogUtils.hideLoading(context);
                        DialogUtils.showMessage(
                            context: context,
                            content: e.toString(),
                            title: 'Log in',
                            posActionName: 'OK',
                            posAction: () => Navigator.pop(context));
                      }
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.login)
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: const Text("Don't have an account? Sign up here"))
            ],
          ),
        ),
      ),
    )));
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }

  String? validateEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.contains('@') && email != null && emailValid) {
      return null;
    }
    return 'Email must have @ and a valid email';
  }

  String? validatePassword(String password) {
    if (password.trim().length >= 6 &&
        password != null &&
        password.isNotEmpty) {
      return null;
    } else {
      return 'Password must be at least 6 characters';
    }
  }
}
