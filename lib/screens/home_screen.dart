import 'package:flutter/material.dart';
import 'package:weather/constants/colors.dart';

import '../components/curtain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? _curtain3animationController;
  Animation<double>? _curtain3sizeAnimation;

  AnimationController? _curtain2animationController;
  Animation<double>? _curtain2sizeAnimation;

  AnimationController? _curtain1animationController;
  Animation<double>? _curtain1sizeAnimation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double screenHeight = MediaQuery.of(context).size.height;
      double appBarHeight = AppBar().preferredSize.height;
      double statusBarHeight = MediaQuery.of(context).padding.top;
      double bodyHeight = screenHeight - appBarHeight - statusBarHeight;

      setState(() {
        _curtain3animationController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 350),
        );
        _curtain3sizeAnimation = Tween<double>(
          begin: bodyHeight / 6 * 3,
          end: bodyHeight / 6 * 5,
        ).animate(CurvedAnimation(parent: _curtain3animationController!, curve: Curves.ease));

        _curtain3animationController!.addListener(() {
          setState(() {});
        });

        _curtain2animationController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 350),
        );
        _curtain2sizeAnimation = Tween<double>(
          begin: bodyHeight / 6 * 2,
          end: bodyHeight / 6 * 4,
        ).animate(CurvedAnimation(parent: _curtain2animationController!, curve: Curves.ease));

        _curtain2animationController!.addListener(() {
          setState(() {});
        });

        _curtain1animationController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 350),
        );
        _curtain1sizeAnimation = Tween<double>(
          begin: bodyHeight / 6,
          end: bodyHeight / 6 * 3,
        ).animate(CurvedAnimation(parent: _curtain1animationController!, curve: Curves.ease));

        _curtain1animationController!.addListener(() {
          setState(() {});
        });
      });
    });
    super.initState();
  }

  _openCurtain4() {
    //close all curtains:
    if (_curtain3animationController?.status == AnimationStatus.completed) {
      _curtain3animationController?.reverse();
    }
    if (_curtain2animationController?.status == AnimationStatus.completed) {
      _curtain2animationController?.reverse();
    }
    if (_curtain1animationController?.status == AnimationStatus.completed) {
      _curtain1animationController?.reverse();
    }
  }

  _openCurtain3() {
    _curtain3animationController?.forward();
    //close other curtains
    if (_curtain2animationController?.status == AnimationStatus.completed) {
      _curtain2animationController?.reverse();
    }
    if (_curtain1animationController?.status == AnimationStatus.completed) {
      _curtain1animationController?.reverse();
    }
  }

  _openCurtain2() {
    _curtain2animationController?.forward();
    //if curtain 3 is not opened should be opened (because it's behind curtain 2)
    if (_curtain3animationController?.status != AnimationStatus.completed) {
      _curtain3animationController?.forward();
    }
    //if curtain 1 is open then close it
    if (_curtain1animationController?.status == AnimationStatus.completed) {
      _curtain1animationController?.reverse();
    }
  }

  _openCurtain1() {
    _curtain1animationController?.forward();
    //all other curtains must be opened
    if (_curtain3animationController?.status != AnimationStatus.completed) {
      _curtain3animationController?.forward();
    }
    if (_curtain2animationController?.status != AnimationStatus.completed) {
      _curtain2animationController?.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = screenHeight - appBarHeight - statusBarHeight;
    return Scaffold(
      backgroundColor: AppColors.curtain4,
      appBar: AppBar(
        title: const Text('Giggle Cast'),
        backgroundColor: AppColors.appbarColor,
      ),
      body: Stack(
        children: [
          Curtain(
            height: bodyHeight,
            curtainColor: AppColors.curtain4,
            openCurtain: _openCurtain4,
          ),
          Curtain(
            height: _curtain3sizeAnimation?.value ?? bodyHeight / 6 * 3,
            curtainColor: AppColors.curtain3,
            openCurtain: _openCurtain3,
          ),
          Curtain(
            height: _curtain2sizeAnimation?.value ?? bodyHeight / 6 * 2,
            curtainColor: AppColors.curtain2,
            openCurtain: _openCurtain2,
          ),
          Curtain(
            height: _curtain1sizeAnimation?.value ?? bodyHeight / 6,
            curtainColor: AppColors.curtain1,
            openCurtain: _openCurtain1,
          ),
        ],
      ),
    );
  }
}
