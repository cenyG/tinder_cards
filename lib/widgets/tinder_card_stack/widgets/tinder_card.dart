import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({
    Key? key,
    required this.bottomBarSize,
    required this.photoUrl,
    this.elevation = 10,
  }) : super(key: key);

  final double bottomBarSize;
  final String photoUrl;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final height = Get.height -
        Get.bottomBarHeight -
        Get.statusBarHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        kBottomNavigationBarHeight;

    const textStyle = TextStyle(color: Colors.white, fontSize: 20);
    const headerTextStyle = TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600);

    final borderRadius = BorderRadius.circular(10);

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        color: Colors.black87,
        elevation: elevation,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(children: [
            AspectRatio(
              aspectRatio: 10 / 16,
              child: Image.network(photoUrl, fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[Colors.black, Colors.black87, Colors.transparent],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Kitty (20)', style: headerTextStyle),
                      const Text('Lives in London', style: textStyle),
                      const Text('6 miles away', style: textStyle),
                      SizedBox(
                        height: bottomBarSize,
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
