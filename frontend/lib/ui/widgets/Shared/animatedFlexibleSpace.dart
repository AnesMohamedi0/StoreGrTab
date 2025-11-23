import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';

class AnimatedFlexibleSpace extends StatefulWidget {
  final bool placeOrder;
  final double raduis;
  const AnimatedFlexibleSpace({
    Key? key,
    this.placeOrder = false,
    this.raduis = 1.5,
  }) : super(key: key);

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
        List<Color> colors;
        List<double> stops;

        if (widget.placeOrder) {
          colors = [
            Color.lerp(electricBlueDark, electricBlueDarker, _animation.value)!,
            Color.lerp(electricBlueDarkest, deepPurpleDark, _animation.value)!,
          ];
          stops = [0.0, 1.0];
        } else {
          colors = [
            Color.lerp(electricBlueDark, electricBlueDarker, _animation.value)!,
            Color.lerp(electricBlueDarkest, deepPurpleDark, _animation.value)!,
            Color.lerp(deepPurpleDarkest, deepPurpleDarker, _animation.value)!,
          ];
          stops = [0.0, 0.5, 1.0];
        }

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.lerp(
                Alignment(-0.5, -0.8),
                Alignment(0.5, 0.8),
                _animation.value,
              )!,
              radius: widget.raduis + (_animation.value * 0.5),
              colors: colors,
              stops: stops,
            ),
          ),
        );
      },
    );
  }
}
