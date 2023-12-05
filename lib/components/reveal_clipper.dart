
import 'package:flutter/material.dart';

class RevealClipper extends CustomClipper<Rect> {
  final GlobalKey objectKey;
  final GlobalKey curtainKey;

  RevealClipper({
    required this.objectKey,
    required this.curtainKey,
  });

  Rect _getGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero) & renderBox.size;
  }

  @override
  Rect getClip(Size size) {
    Rect objectRect = _getGlobalRect(objectKey);
    Rect curtainRect = _getGlobalRect(curtainKey);
    double bottomOverlap = objectRect.bottom - curtainRect.top;
    if (bottomOverlap > 0) {
      return Rect.fromPoints(Offset(0.0, size.height - bottomOverlap), Offset(size.width, size.height));
    }
    return Rect.fromPoints(const Offset(0.0, 00.0),  const Offset(0, 0));
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}