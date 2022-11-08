import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' as vm;
import 'dart:math' as math;

import 'widgets/action_buttons_bar.dart';
import 'widgets/like_diss_label.dart';
import 'widgets/tinder_card.dart';

class TinderCardStack extends StatefulWidget {
  static Page<void> page() => const MaterialPage<void>(child: TinderCardStack());

  final double aspectRatio;

  const TinderCardStack({
    Key? key,
    this.aspectRatio = 9 / 16,
  }) : super(key: key);

  @override
  State<TinderCardStack> createState() => _TinderCardStackState();
}

class _TinderCardStackState extends State<TinderCardStack> with SingleTickerProviderStateMixin {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    const tmpUrls = [
      'https://media.npr.org/assets/img/2021/08/11/gettyimages-1279899488_wide-f3860ceb0ef19643c335cb34df3fa1de166e2761-s1100-c50.jpg',
      'https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg',
      'https://i.ytimg.com/vi/eX2qFMC8cFo/mqdefault.jpg',
      'https://assets.entrepreneur.com/content/3x2/2000/how-win-social-media-right-now-silly-cat-pics-dont-cut.jpg?crop=4:3',
    ];

    const bottomBarSize = 100.0;

    const maxOffset = 200;
    final tmpDiff = math.min(maxOffset, offset.dx.abs()) / maxOffset;

    final dyOffset = (1 - tmpDiff) * 20;
    final scale = 0.95 + tmpDiff * 0.05;
    final elevation = 8 * tmpDiff;

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(clipBehavior: Clip.none, children: [
        Transform(
          alignment: Alignment.topCenter,
          transform:
              vm.Matrix4.compose(vm.Vector3(0, dyOffset, 0), vm.Quaternion(0, 0, 0, 0), vm.Vector3(scale, scale, 1)),
          child: TinderCard(
            bottomBarSize: bottomBarSize,
            photoUrl: tmpUrls[0],
            elevation: elevation,
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 50),
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    offset += details.delta;
                  });
                },
                onPanEnd: (_) => setState(() {
                      offset = Offset.zero;
                    }),
                onPanCancel: () => setState(() {
                      offset = Offset.zero;
                    }),
                child: Stack(
                  children: [
                    TinderCard(
                      bottomBarSize: bottomBarSize,
                      photoUrl: tmpUrls[1],
                    ),
                    LikeDissLabel(
                      opacity: offset.dx > 0 ? tmpDiff : 0,
                      type: LikeDissType.like,
                    ),
                    LikeDissLabel(
                      opacity: offset.dx < 0 ? tmpDiff : 0,
                      type: LikeDissType.diss,
                    ),
                  ],
                ))),
        const Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: bottomBarSize,
            child: ActionButtonsBar(),
          ),
        )
      ]),
    );
  }
}
