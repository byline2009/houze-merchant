import 'package:flutter/material.dart';

import '../skeleton_config.dart';
import './card_skeleton.dart';

class CardListSkeleton extends StatelessWidget {
  final SkeletonConfig config;
  final int length;
  final bool shrinkWrap;

  CardListSkeleton({
    Key? key,
    this.config: const SkeletonConfig.origin(),
    this.length: 10,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: this.shrinkWrap,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 0.0),
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: CardSkeleton(config: config),
        );
      },
    );
  }
}
