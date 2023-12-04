import 'package:flutter/material.dart';
import 'package:weather/components/reveal_clipper.dart';

class Curtain extends StatelessWidget {
  const Curtain({
    super.key,
    required this.height,
    required this.curtainColor,
    required this.openCurtain,
  });

  final double height;
  final Color curtainColor;
  final Function() openCurtain;

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
            InkWell(
              onTap: openCurtain,
              child: Container(
                key: curtainKey,
                color: curtainColor,
                width: MediaQuery.sizeOf(context).width,
                height: height,
              ),
            )
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
