import 'package:flutter/material.dart';

import '../skeleton_config.dart';
import '../skeleton_animation.dart';
import '../skeleton_decoration.dart';
import '../skeleton_theme.dart';
import './card_skeleton.dart';

class CardListHorizontalSkeleton extends StatefulWidget {

  final SkeletonConfig config;
  final int length;
  final bool shrinkWrap;

  CardListHorizontalSkeleton({
    Key key,
    this.config: const SkeletonConfig.origin(),
    this.length: 5,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardListHorizontalSkeletonState();
}

class _CardListHorizontalSkeletonState extends State<CardListHorizontalSkeleton> 
    with SingleTickerProviderStateMixin  {

  SkeletonAnimation _skeletonAnimation;

  @override
  void initState() {
    super.initState();
    _skeletonAnimation = SkeletonAnimation(this);
  }

  @override
  void dispose() {
    _skeletonAnimation.dispose();
    super.dispose();
  }

  Color get backgroundColor {
    if (widget.config.theme == SkeletonTheme.Dark) {
      return Color(0xff424242);
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _skeletonAnimation.animation,
      builder: (context, child) {

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(bottom: 30.0, right: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Container(
                width: width * 35/100,
                decoration: SkeletonDecoration(
                  _skeletonAnimation,
                  theme: widget.config.theme,
                  borderRadius: 16.0,
                ),
              ),
            );
          });

      }
    );
  }
}
