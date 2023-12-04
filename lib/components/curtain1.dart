import 'package:flutter/material.dart';
import 'package:weather/components/reveal_clipper.dart';
import 'package:weather/constants/colors.dart';

class Curtain1 extends StatelessWidget {
  const Curtain1({
    super.key,
    required this.containerHeight,
  });

  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    final GlobalKey curtainKey = GlobalKey();
    final GlobalKey objectKey = GlobalKey();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              key: curtainKey,
              color: AppColors.curtain1,
              width: MediaQuery.sizeOf(context).width,
              height: containerHeight,
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 1.9,
          child: ClipRect(
            key: UniqueKey(),
            clipper: RevealClipper(objectKey: objectKey, curtainKey: curtainKey),
            child: Container(
              key: objectKey,
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
