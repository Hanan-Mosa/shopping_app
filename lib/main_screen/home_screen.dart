import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shopping_app/main_screen/item_widget.dart';
import 'package:shopping_app/profile/profile_view.dart';

import 'card_widget.dart';
import 'text_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            tr('welcome to app'),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  if (!isAuthenticated) {
                    try {
                      bool canAuthenticateWithBiometrics =
                          await auth.canCheckBiometrics;
                      bool isDeviceSupported = await auth.isDeviceSupported();
                      if (canAuthenticateWithBiometrics && isDeviceSupported) {
                        final bool didAuthenticated = await auth.authenticate(
                            localizedReason:
                                'please, authenticate to access profile page ',
                            options: const AuthenticationOptions(
                                biometricOnly: true));
                        setState(() {
                          isAuthenticated = didAuthenticated;
                        });
                        Navigator.pushNamed(context, ProfileView.routeName);
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  } else {
                    setState(() {
                      isAuthenticated = false;
                    });
                  }
                },
                icon: const CircleAvatar(
                    backgroundColor: Colors.white30,
                    child: Icon(Icons.person, color: Colors.white)))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextWidget(text: tr('our products')),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    Image.asset('assets/images/product${index + 1}.jpg'),
                itemCount: 5,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => CardWidget(index: index),
                itemCount: 4,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(text: tr('hot offers')),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ItemWidget(index: index),
                itemCount: 5,
              ),
            ),
          ]),
        ));
  }
}
