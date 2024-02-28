// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [CircularProgressIndicator(), Text(message)],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      String? title,
      String? posActionName,
      Function? posAction,
      String? negActionName,
      Function? negAction}) {
    List<Widget> actins = [];
    if (posActionName != null) {
      actins.add(TextButton(
          onPressed: () {
            if (posAction != null) {
              posAction.call();
            }
           //Navigator.pop(context);
          },
          child: Text(posActionName)));
    }
    if (negActionName != null) {
      actins.add(ElevatedButton(
          onPressed: () {
            if (negAction != null) {
              negAction.call();
            }
            Navigator.pop(context);
          },
          child: Text(negActionName)));
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          title: Text(title ?? ''),
          actions: actins,
        );
      },
    );
  }
}
