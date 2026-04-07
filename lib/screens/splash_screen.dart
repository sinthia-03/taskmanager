import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanager/controller/auth_controller.dart';
import '../utilits/asset_path.dart';
import 'loginScreen.dart';
import 'main_navi_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    movetoNextScreen();
  }

  Future<void>movetoNextScreen()async {
    await Future.delayed(Duration(seconds: 3));
     await AuthController.getUserData();
    final bool isLoggIn= await AuthController.isUserLoggIn();

    if (isLoggIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNaviScreen()));

    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(AssetPaths.backgroundSVG),
            Center(child: SvgPicture.asset(AssetPaths.logoSVG)),
          ],
        )
    );
  }
}