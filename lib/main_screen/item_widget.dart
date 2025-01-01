import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  int index;

  ItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset('assets/images/product${index + 1}.jpg')),
          const SizedBox(
            height: 10,
          ),
          Text(
            'product${index + 1}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
