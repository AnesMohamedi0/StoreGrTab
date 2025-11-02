import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';

class AnimatedFlexibleSpace extends StatefulWidget {
  const AnimatedFlexibleSpace({Key? key}) : super(key: key);

  @override
  State<AnimatedFlexibleSpace> createState() => _AnimatedFlexibleSpaceState();
}

class _AnimatedFlexibleSpaceState extends State<AnimatedFlexibleSpace>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.lerp(
                Alignment(-0.5, -0.8),
                Alignment(0.5, 0.8),
                _animation.value,
              )!,
              radius: 1.5 + (_animation.value * 0.5),
              colors: [
                Color.lerp(electricBlue, electricBlueLight, _animation.value)!,
                Color.lerp(
                  electricBlueLight,
                  deepPurpleLighter,
                  _animation.value,
                )!,
                Color.lerp(
                  deepPurpleLighter,
                  deepPurpleLight,
                  _animation.value,
                )!,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
