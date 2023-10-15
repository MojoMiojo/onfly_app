import 'package:flutter/material.dart';

class OnflyFilledButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const OnflyFilledButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => onPressed,
      style: const ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
