import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/views/main_screen.dart';
import 'package:fl_chart/fl_chart.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.offAll(() => HomeScreen()),
                icon: const Icon(Icons.arrow_back),
              ),
              Image.asset(ConstImage.baner, height: 48, width: 48),
              InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Image.asset(ConstImage.userinfo, height: 48, width: 48),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 70 : 60;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            radius: radius,
            badgeWidget: Image.asset(ConstImage.foodhubPng, width: 30),
            badgePositionPercentageOffset: 1.2,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: 30,
            radius: radius,
            badgeWidget: Image.asset(ConstImage.justeatPng, width: 30),
            badgePositionPercentageOffset: 1.2,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            radius: radius,
            badgeWidget: Image.asset(ConstImage.feedmeonlineJpg, width: 30),
            badgePositionPercentageOffset: 1.2,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: 25,
            radius: radius,
            badgeWidget: Image.asset(ConstImage.mealzo, width: 30),
            badgePositionPercentageOffset: 1.2,
          );
        default:
          throw Error();
      }
    });
  }
}
