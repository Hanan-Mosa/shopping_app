import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/login_screen/text_form_field_widget.dart';
import 'package:shopping_app/main_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('ar', 'EG'));
    return SafeArea(
        child: Scaffold(
            body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      myDialog();
                    }
                    setState(() {});
                  },
                  child: const Text('Sign up'))
            ],
          ),
        ),
      ),
    )));
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

  myDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign_Up Message'),
          content: const Text('Account created successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: const Text('close'),
            )
          ],
        ));
  }
}
