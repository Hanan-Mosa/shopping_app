import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  int index;

  CardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 15),
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
            'Product${index + 1}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
              onTap: () {
                const snackBar = SnackBar(
                  content: Text(
                    'Item added to cart',
                    style: TextStyle(fontSize: 18),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Icon(
                Icons.add_shopping_cart,
                size: 30,
              ))
        ],
      ),
    );
  }
}
