import 'package:cardapp/auth/animated_shape/top_shape.dart';
import 'package:flutter/material.dart';

class AnimatedShape extends StatefulWidget {
  final Color color;
  final bool show;
  final String title, subTitle;

  const AnimatedShape({super.key, required this.color, required this.show, required this.title, required this.subTitle});

  @override
  State<AnimatedShape> createState() => _AnimatedShapeState();
}

class _AnimatedShapeState extends State<AnimatedShape> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  // @override
  // void didUpdateWidget(covariant AnimatedShape oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   widget.show ? _animationController.reverse() : _animationController.forward();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 209,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => TopShape.draw(
          widget.color,
          widget.title,
          widget.subTitle,
          _animationController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
