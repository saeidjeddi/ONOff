import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onoff/components/imageUrlConst.dart';
import 'package:onoff/components/widgets.dart';
import 'package:onoff/controller/count_controller.dart';
import 'package:onoff/controller/status_controller.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CountController countController = Get.put(CountController());
  StatusController statusController = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    countController.getCount();
    statusController.getStatus();

    return Scaffold(
      key: _key,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: Icon(Icons.menu, size: 30),
            ),

            SizedBox(width: Get.width / 3.4),

            Image.asset(
              ImageUrlConst.baner,
              height: 40,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),

      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SizedBox(
                width: Get.width,
                height: 150,

                child: Center(
                  child: Image.asset(ImageUrlConst.onoff, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),

              ListTile(
                leading: Icon(Icons.home, color: Colors.grey),
                title: Text('Home'),
                onTap: () {
                  Get.back();
                },
              ),
              Divider(color: Colors.grey.shade300, thickness: 1),

              ListTile(
                leading: Icon(Icons.web, color: Colors.grey),
                title: Text('Website'),
                onTap: () {
                  Get.back();
                },
              ),
              Divider(color: Colors.grey.shade300, thickness: 1),
              SizedBox(height: size.height / 1.9),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Version 0.0.1',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 12),

                  Text(
                    'Powered by R&D Team',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (countController.loding.value == false) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 239, 240),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Icon(Icons.ad_units_rounded),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Total Device',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              countController.countInfo.value.allCount
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.ad_units_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Total Off Device',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              countController.countInfo.value.allOff.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.ad_units_rounded,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Total On Device',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              countController.countInfo.value.allOn.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 115,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              blurRadius: 1,
                              spreadRadius: 0.5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                ImageUrlConst.foodHub,
                                height: 60,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  countController.countInfo.value.foodhub.total
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'On:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  countController.countInfo.value.foodhub.on
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Off:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  countController.countInfo.value.foodhub.off
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    countController
                                        .countInfo
                                        .value
                                        .foodhub
                                        .lastTime,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 115,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              blurRadius: 1,
                              spreadRadius: 0.5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                ImageUrlConst.justEat,
                                height: 60,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Total : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  countController.countInfo.value.justeat.total
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'On : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  countController.countInfo.value.justeat.on
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Off : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  countController.countInfo.value.justeat.off
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    countController
                                        .countInfo
                                        .value
                                        .justeat
                                        .lastTime,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 115,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              blurRadius: 1,
                              spreadRadius: 0.5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                ImageUrlConst.uberEats,
                                height: 60,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Total : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  countController.countInfo.value.ubereats.total
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'On : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  countController.countInfo.value.ubereats.on
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Off : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  countController.countInfo.value.ubereats.off
                                      .toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    countController
                                        .countInfo
                                        .value
                                        .ubereats
                                        .lastTime,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32),

                Row(
                  children: [
                    SearchBox(),
                    const SizedBox(width: 12),

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.send, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: statusController.restaurantResults.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              statusController
                                  .restaurantResults[index]
                                  .mealzoName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Just Eat:"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (statusController
                                            .restaurantResults[index]
                                            .companies
                                            .justeat
                                            ?.deviceAvailability ==
                                        true) ...[
                                      Text(
                                        statusController
                                                    .restaurantResults[index]
                                                    .companies
                                                    .justeat!
                                                    .data
                                                    ?.isOpen ==
                                                true
                                            ? "online"
                                            : "offline",
                                        style: TextStyle(
                                          color:
                                              statusController
                                                      .restaurantResults[index]
                                                      .companies
                                                      .justeat!
                                                      .data
                                                      ?.isOpen ==
                                                  true
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        Icons.brightness_1_sharp,
                                        color:
                                            statusController
                                                    .restaurantResults[index]
                                                    .companies
                                                    .justeat!
                                                    .data
                                                    ?.isOpen ==
                                                true
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ] else ...[
                                      Text(
                                        "Not available",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        Icons.brightness_1_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Uber Eats:"),
                                Row(
                                  children: [
                                    if (statusController
                                            .restaurantResults[index]
                                            .companies
                                            .ubereats
                                            ?.deviceAvailability ==
                                        true) ...[
                                      Text(
                                        statusController
                                                    .restaurantResults[index]
                                                    .companies
                                                    .ubereats!
                                                    .data
                                                    ?.isOpen ==
                                                true
                                            ? "online"
                                            : "offline",
                                        style: TextStyle(
                                          color:
                                              statusController
                                                      .restaurantResults[index]
                                                      .companies
                                                      .ubereats!
                                                      .data
                                                      ?.isOpen ==
                                                  true
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        Icons.brightness_1_sharp,
                                        color:
                                            statusController
                                                    .restaurantResults[index]
                                                    .companies
                                                    .ubereats!
                                                    .data
                                                    ?.isOpen ==
                                                true
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ] else ...[
                                      Text(
                                        "Not available",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        Icons.brightness_1_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Food Hub:"),
                                Row(
                                  children: [
                                    if (statusController
                                            .restaurantResults[index]
                                            .companies
                                            .foodhub
                                            ?.deviceAvailability ==
                                        true) ...[
                                      Text(
                                        statusController
                                                    .restaurantResults[index]
                                                    .companies
                                                    .foodhub!
                                                    .data
                                                    ?.isOpen ==
                                                true
                                            ? "online"
                                            : "offline",
                                        style: TextStyle(
                                          color:
                                              statusController
                                                      .restaurantResults[index]
                                                      .companies
                                                      .foodhub!
                                                      .data
                                                      ?.isOpen ==
                                                  true
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        Icons.brightness_1_sharp,
                                        color:
                                            statusController
                                                    .restaurantResults[index]
                                                    .companies
                                                    .foodhub!
                                                    .data
                                                    ?.isOpen ==
                                                true
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ] else ...[
                                      Text(
                                        "Not available",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(width: 16),
                                      Icon(
                                        Icons.brightness_1_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
