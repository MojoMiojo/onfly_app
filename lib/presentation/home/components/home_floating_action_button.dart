part of '../home_page.dart';

class _HomeFloatingActionButton extends StatefulWidget {
  const _HomeFloatingActionButton();

  @override
  State<_HomeFloatingActionButton> createState() =>
      _HomeFloatingActionButtonState();
}

class _HomeFloatingActionButtonState extends State<_HomeFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(
        Icons.add,
      ),
    );
  }
}