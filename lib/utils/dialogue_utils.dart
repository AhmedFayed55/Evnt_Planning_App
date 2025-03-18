import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class DialogueUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    message,
                    style: AppStyles.medium16Black,
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? ngeActionName,
    Function? ngeAction,
  }) {
    List<Widget> actions = [];

    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: AppStyles.medium16Primary,
          )));
    }

    if (ngeActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            ngeAction?.call();
          },
          child: Text(
            ngeActionName,
            style: AppStyles.medium16Primary,
          )));
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            title: Text(
              title ?? "",
              style: AppStyles.medium16Black,
            ),
            actions: actions,
          );
        });
  }
}
