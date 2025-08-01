import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/views/login_screen.dart';
import 'package:onofflive/views/main_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CountController countController = Get.put(CountController());
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final results = await Future.wait([
      countController.getCount(), 
      Future.delayed(const Duration(seconds: 3)),
    ]);

    final success = results[0] as bool;

    if (success) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => UsrLoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Image.asset(
          ConstImage.splash,
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
