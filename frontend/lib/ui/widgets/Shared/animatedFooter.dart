import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';

class AnimatedFooter extends StatefulWidget {
  const AnimatedFooter({super.key});

  @override
  State<AnimatedFooter> createState() => _AnimatedFooterState();
}

class _AnimatedFooterState extends State<AnimatedFooter>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 40),
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
        List<Color> colors;
        List<double> stops;

        colors = [
          Color.lerp(electricBlueDark, electricBlueDarkest, _animation.value)!,
          Color.lerp(electricBlueDarkest, electricBlueDark, _animation.value)!,
          Color.lerp(electricBlueDark, electricBlueDarkest, _animation.value)!,
        ];
        stops = [0.0, 0.5, 1.0];

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.lerp(
                Alignment(-0.5, -0.8),
                Alignment(0.5, 0.8),
                _animation.value,
              )!,
              radius: 5 + (_animation.value * 0.5),
              colors: colors,
              stops: stops,
            ),
          ),
        );
      },
    );
  }
}
