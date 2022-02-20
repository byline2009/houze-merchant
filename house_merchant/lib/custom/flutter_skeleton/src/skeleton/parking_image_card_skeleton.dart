import 'package:flutter/material.dart';

class ParkingCardSkeleton extends StatefulWidget {
  final double height;
  final double width;
  final double borderRadius;

  ParkingCardSkeleton(
      {Key? key, this.height = 20, this.width = 200, this.borderRadius = 0})
      : super(key: key);

  createState() => ParkingCardSkeletonState();
}

class ParkingCardSkeletonState extends State<ParkingCardSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Animation? gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(gradientPosition!.value, 0),
            end: Alignment(-1, 0),
            colors: [Colors.black12, Colors.black26, Colors.black12],
          ),
        ),
      ),
    );
  }
}
