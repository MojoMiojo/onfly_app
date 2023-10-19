import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onfly_app/presentation/utils/onfly_colors.dart';

class OnflyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final List<Widget>? actions;

  const OnflyAppBar({
    super.key,
    this.title,
    this.actions
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      actions: actions,
      backgroundColor: OnflyColors.brandPrimary,
      iconTheme: IconThemeData(color: OnflyColors.white),
      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.white),
            )
          : SvgPicture.asset(
              'assets/svg/onfly_logo.svg',
              height: 32,
            ),
    );
  }
}
