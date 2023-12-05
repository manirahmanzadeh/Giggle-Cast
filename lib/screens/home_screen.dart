import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/constants/colors.dart';

import '../components/curtain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  double? topPosition;
  double? _curtain1Height;
  double? _curtain2Height;
  double? _curtain3Height;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animationController!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = MediaQuery.of(context).size.height;
        double appBarHeight = AppBar().preferredSize.height;
        double statusBarHeight = MediaQuery.of(context).padding.top;
        double bottomPadding = MediaQuery.of(context).padding.bottom;
        double bodyHeight = screenHeight - appBarHeight - statusBarHeight - bottomPadding;
        if (screenHeight > 0) {
          _initializeFirstSizes(bodyHeight);
        }
        return Scaffold(
          backgroundColor: AppColors.curtain4,
          appBar: AppBar(
            title: const Text('Giggle Cast (Hava Chitor)'),
            backgroundColor: AppColors.appbarColor,
          ),
          body: Stack(
            children: [
              Curtain(
                height: bodyHeight,
                curtainColor: AppColors.curtain4,
                openCurtain: () => _openCurtain4(bodyHeight),
                topPosition: topPosition ?? 0,
                temperature: -1,
                humidity: 91,
                time: 'M O R N I N G',
                weather: 'Sunny',
                windDirection: 'E',
                windSpeed: 7,
                weatherIcon: SvgPicture.asset(
                  'assets/icons/sun-solid.svg',
                  height: bodyHeight / 6,
                ),
              ),
              Curtain(
                height: _curtain3Height ?? bodyHeight / 6 * 3,
                curtainColor: AppColors.curtain3,
                openCurtain: () => _openCurtain3(bodyHeight),
                topPosition: topPosition ?? 0,
                temperature: 3,
                humidity: 45,
                time: 'D A Y',
                weather: 'Mostly Sunny',
                windDirection: 'N',
                windSpeed: 5,
                weatherIcon: SvgPicture.asset('assets/icons/cloud-sun-solid.svg', height: bodyHeight / 6),
              ),
              Curtain(
                height: _curtain2Height ?? bodyHeight / 6 * 2,
                curtainColor: AppColors.curtain2,
                openCurtain: () => _openCurtain2(bodyHeight),
                topPosition: topPosition ?? 0,
                temperature: 0,
                humidity: 91,
                time: 'E V E N I N G',
                weather: 'Rain',
                windDirection: 'W',
                windSpeed: 12,
                weatherIcon: SvgPicture.asset('assets/icons/cloud-sun-rain-solid.svg', height: bodyHeight / 6),
              ),
              Curtain(
                height: _curtain1Height ?? bodyHeight / 6,
                curtainColor: AppColors.curtain1,
                openCurtain: () => _openCurtain1(bodyHeight),
                topPosition: topPosition ?? 0,
                temperature: -2,
                humidity: 47,
                time: 'N I G H T',
                weather: 'Cloudy',
                windDirection: 'N',
                windSpeed: 2,
                weatherIcon: SvgPicture.asset('assets/icons/cloud-moon-solid.svg', height: bodyHeight / 6),
              ),
            ],
          ),
        );
      },
    );
  }

  _initializeFirstSizes(double bodyHeight) {
    if ([topPosition, _curtain3Height, _curtain2Height, _curtain1Height].contains(null)) {
      _openCurtain4(bodyHeight);
    }
  }

  _openCurtain4(double bodyHeight) {
    setState(() {
      ///transfer object to top:
      topPosition = 0;

      ///close all curtains:
      _curtain3Height = bodyHeight / 6 * 3;
      _curtain2Height = bodyHeight / 6 * 2;
      _curtain1Height = bodyHeight / 6;
    });

    ///run ticker animation:
    _runAnimation();
  }

  _openCurtain3(double bodyHeight) {
    setState(() {
      ///transfer object to second position:
      topPosition = bodyHeight / 6;

      ///open curtain 3:
      _curtain3Height = bodyHeight / 6 * 5;

      ///close other curtains:
      _curtain2Height = bodyHeight / 6 * 2;
      _curtain1Height = bodyHeight / 6;
    });

    ///run ticker animation:
    _runAnimation();
  }

  _openCurtain2(double bodyHeight) {
    setState(() {
      /// transfer object to third position:
      topPosition = bodyHeight / 6 * 2;

      ///open curtain 2:
      _curtain2Height = bodyHeight / 6 * 4;

      ///open curtain 3 because it must be behind curtain 2
      _curtain3Height = bodyHeight / 6 * 5;

      ///close other curtains:
      _curtain1Height = bodyHeight / 6;
    });

    ///run ticker animation:
    _runAnimation();
  }

  _openCurtain1(double bodyHeight) {
    setState(() {
      ///transfer object to last position:
      topPosition = bodyHeight / 6 * 3;

      ///open all curtains:
      _curtain1Height = bodyHeight / 6 * 3;
      _curtain2Height = bodyHeight / 6 * 4;
      _curtain3Height = bodyHeight / 6 * 5;
    });

    ///run ticker animation:
    _runAnimation();
  }

  _runAnimation() {
    ///this is for ticking in time so setState will be applied to whole page
    _animationController?.reset();
    _animationController?.forward();
  }
}
