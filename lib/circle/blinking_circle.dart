import 'package:blinking_shapes/circle//circle.dart';
import 'package:flutter/material.dart';

class BlinkingCircle extends StatefulWidget {
  final double xCoordination;
  final double yCoordination;
  final Color pointColor;
  final double pointSize;

  const BlinkingCircle({
    super.key,
    required this.xCoordination,
    required this.yCoordination,
    required this.pointColor,
    required this.pointSize,
  });

  @override
  BlinkingCircleState createState() => BlinkingCircleState();
}

class BlinkingCircleState extends State<BlinkingCircle>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: widget.pointSize * 4)
        .animate(animationController);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LogoAnimation(
      xCoordination: widget.xCoordination,
      yCoordination: widget.yCoordination,
      pointColor: widget.pointColor,
      pointSize: widget.pointSize,
      animation: animation,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class LogoAnimation extends AnimatedWidget {
  final double xCoordination;
  final double yCoordination;
  final Color pointColor;
  final double pointSize;

  const LogoAnimation({
    Key? key,
    required Animation animation,
    required this.xCoordination,
    required this.yCoordination,
    required this.pointColor,
    required this.pointSize,
  }) : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    Animation? animation = listenable as Animation?;
    return CustomPaint(
      foregroundPainter: Circle(
        xCoordination: xCoordination,
        yCoordination: yCoordination,
        color: pointColor,
        pointSize: pointSize,
        blinkRadius: animation!.value,
      ),
    );
  }
}
