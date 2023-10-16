import 'package:flutter/material.dart';

class OnflyFilledButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final double padding;

  const OnflyFilledButton({
    Key? key,
    required this.onPressed,
    required this.child,
      this.padding = 12
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => onPressed,
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(padding)),
        shape: const MaterialStatePropertyAll(
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
