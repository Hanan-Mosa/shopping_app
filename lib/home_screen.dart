import 'package:flutter/material.dart';

import 'card_widget.dart';
import 'item_widget.dart';
import 'text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Welcome to our shopping App'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextWidget(text: 'Our Products'),
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
            TextWidget(text: 'Hot Offers'),
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
