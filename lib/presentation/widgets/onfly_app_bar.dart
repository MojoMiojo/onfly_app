import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onfly_app/presentation/utils/onfly_colors.dart';

class OnflyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;

  const OnflyAppBar({
    super.key,
    this.title,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: OnflyColors.white,
      ),
      backgroundColor: OnflyColors.brandPrimary,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(color: Colors.white),
            )
          : SvgPicture.asset(
              'assets/svg/onfly_logo.svg',
              height: 32,
            ),
    );
  }
}
