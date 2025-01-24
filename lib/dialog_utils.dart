import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16.0),
                Text(' Loading...')
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String content,
      String? title,
      String? posActionName,
      Function? posAction}) {
    List<Widget> actions = [];
    if (posActionName != null && posAction != null) {
      actions.add(
        TextButton(
          onPressed: () {
            posAction.call();
          },
          child: Text(posActionName),
        ),
      );
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text(content),
            title: Text(title ?? ''),
            actions: actions,
          );
        });
  }
}
