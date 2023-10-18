part of '../home_page.dart';

class _HomeFloatingActionButton extends StatefulWidget {
  final Function onPressed;

  const _HomeFloatingActionButton(this.onPressed);

  @override
  State<_HomeFloatingActionButton> createState() =>
      _HomeFloatingActionButtonState();
}

class _HomeFloatingActionButtonState extends State<_HomeFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => widget.onPressed.call(),
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
