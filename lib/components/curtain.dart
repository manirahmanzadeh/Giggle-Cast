import 'package:flutter/material.dart';
import 'package:weather/components/reveal_clipper.dart';

class Curtain extends StatelessWidget {
  const Curtain({
    super.key,
    required this.height,
    required this.curtainColor,
    required this.openCurtain,
    required this.weatherIcon,
    required this.topPosition,
    required this.time,
    required this.weather,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.temperature,
  });

  final double height;
  final Color curtainColor;
  final Function() openCurtain;
  final Widget weatherIcon;
  final double topPosition;
  final String time;
  final String weather;
  final int windSpeed;
  final String windDirection;
  final int humidity;
  final int temperature;

  @override
  Widget build(BuildContext context) {
    final GlobalKey curtainKey = GlobalKey();
    final GlobalKey objectKey = GlobalKey();
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double bodyHeight = screenHeight - appBarHeight - statusBarHeight - bottomPadding;
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          top: bodyHeight - height,
          child: InkWell(
            onTap: openCurtain,
            child: Container(
              key: curtainKey,
              color: curtainColor,
              width: MediaQuery.sizeOf(context).width,
              height: bodyHeight,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white60,
                    ),
                  ),
                  Text(
                    temperature > 1 ? '+$temperature°' : '$temperature°',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.ease,
          top: topPosition,
          child: ClipRect(
            key: UniqueKey(),
            clipper: RevealClipper(objectKey: objectKey, curtainKey: curtainKey),
            child: SizedBox(
              key: objectKey,
              width: MediaQuery.sizeOf(context).width,
              height: bodyHeight / 6 * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: weatherIcon,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weather,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Wind: $windDirection $windSpeed mph',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Humidity: $humidity%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
