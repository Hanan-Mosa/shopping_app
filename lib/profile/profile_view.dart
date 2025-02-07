import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/auth/login_screen/login_screen.dart';

class ProfileView extends StatefulWidget {
  static const String routeName = "profile";

  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? name;

  String? email;

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    email = prefs.getString('email');
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpyrSRCy6pL1Bd5z_HLb-PXi4jcoFk7eQ62w&s',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: MediaQuery.of(context).size.width * 0.37,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(name ?? ''),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(email ?? ''),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                },
                icon: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Log out'),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.logout,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
