import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/auth/login_screen/login_screen.dart';
import 'package:shopping_app/auth/text_form_field_widget.dart';
import 'package:shopping_app/dialog_utils.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "signup";

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                  controller: nameController,
                  labelText: tr('name'),
                  type: TextInputType.name,
                  validate: validateName,
                  hidden: false,
                ),
                const SizedBox(
                  height: 10,
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
                TextFormFieldWidget(
                  controller: confirmPasswordController,
                  labelText: tr('password_confirmation'),
                  type: TextInputType.text,
                  validate: validateConfirmPassword,
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
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          clear();
                          DialogUtils.hideLoading(context);
                          DialogUtils.showMessage(
                              context: context,
                              content: 'Account Created Successfully',
                              title: 'Register',
                              posActionName: 'Ok',
                              posAction: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen())));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            DialogUtils.hideLoading(context);
                            DialogUtils.showMessage(
                                context: context,
                                content:
                                    'The account already exists for that email.',
                                title: 'Error',
                                posActionName: 'Ok',
                                posAction: () => Navigator.pop(context));
                          }
                        } catch (e) {
                          DialogUtils.hideLoading(context);
                          DialogUtils.showMessage(
                              context: context,
                              content: e.toString(),
                              title: 'Error',
                              posActionName: 'Ok',
                              posAction: () => Navigator.pop(context));
                        }
                      }
                    },
                    child: const Text('Sign up'))
              ],
            ),
          ),
        ),
      ),
    )));
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    confirmPasswordController.clear();
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

  String? validateName(String name) {
    if ((name.codeUnitAt(0) >= 65 && name.codeUnitAt(0) <= 90) &&
        name != null &&
        name.isNotEmpty) {
      return null;
    }
    return 'First letter in Full name must be capitalized';
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

  String? validateConfirmPassword(String confirmPassword) {
    if (confirmPassword == passwordController.text &&
        confirmPassword != null &&
        confirmPassword.isNotEmpty) {
      return null;
    } else {
      return 'confirm field must match with the password field';
    }
  }
}
