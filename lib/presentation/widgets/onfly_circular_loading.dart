import 'package:flutter/material.dart';
import 'package:onfly_app/presentation/utils/onfly_colors.dart';

class OnflyCircularLoading extends StatelessWidget {
  const OnflyCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      color: OnflyColors.brandPrimary,
    );
  }
}
