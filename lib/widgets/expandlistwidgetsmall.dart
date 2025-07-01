import 'package:flutter/material.dart';

// I've renamed it to ExpandedSection to be more standard, but you can keep your name.
class ExpandedSectionAdjust extends StatefulWidget {
  final Widget child;
  final bool expand;

  const ExpandedSectionAdjust({super.key, this.expand = false, required this.child});

  @override
  _ExpandedSectionAdjustState createState() => _ExpandedSectionAdjustState();
}

class _ExpandedSectionAdjustState extends State<ExpandedSectionAdjust>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  /// Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // A slightly faster duration
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
  void didUpdateWidget(ExpandedSectionAdjust oldWidget) {
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
    // The widget is now extremely simple. It just wraps the child
    // in a SizeTransition. It does not impose any size on its child.
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: widget.child,
    );
  }
}