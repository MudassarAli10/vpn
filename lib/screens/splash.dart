import 'package:flutter/material.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:get/route_manager.dart';
import '../main.dart';
//import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      Get.off(() => HomeScreen());
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: mq.width * .3,
              top: mq.height * .35,
              width: mq.width * .4,
              child: Image.asset('assets/images/logo.png'),
            ),
            Positioned(
              left: mq.width * .25,
              bottom: mq.height * .35,
              child: Text('Safe & Secure VPN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
