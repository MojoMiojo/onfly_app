import 'package:flutter/material.dart';

class ShowMoreAnimator extends StatefulWidget {
  final bool expand;
  final Widget child;

  const ShowMoreAnimator({
    super.key,
    this.expand = false,
    required this.child,
  });

  @override
  ShowMoreAnimatorState createState() => ShowMoreAnimatorState();
}

class ShowMoreAnimatorState extends State<ShowMoreAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ShowMoreAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1,
      sizeFactor: animation,
      child: widget.child,
    );
  }
}
