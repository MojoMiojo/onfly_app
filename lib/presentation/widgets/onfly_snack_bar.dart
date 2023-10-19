import 'package:flutter/material.dart';
import 'package:onfly_app/presentation/utils/onfly_colors.dart';

class OnflySnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class OnflyDialog {
  static Future show(BuildContext context, Function onApprove) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: OnflyColors.cultured,
        title: const Text('Delete expense'),
        content: const Text('Do you really want to exclude this expense?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onApprove();
              Navigator.pop(context);
            },
            child: Text(
              'Erase',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: OnflyColors.burntSienna,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
