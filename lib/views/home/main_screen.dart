import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onoff/components/imageUrlConst.dart';
import 'package:onoff/components/widgets.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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

                  Text('Powered by R&D Team', style: TextStyle(color: Colors.grey.shade500)),
                ],
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
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
                            '256',
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
                            '256',
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
                            '256',
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
                      width: 110,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 16,
                            spreadRadius: 3,
                            offset: const Offset(1, 5),
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
                            children: const [
                              Text(
                                'total:',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text('60', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'on:',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text('30', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'off:',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text('45', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "23 Jul 2025 - 11:53",
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
                      width: 110,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 16,
                            spreadRadius: 3,
                            offset: const Offset(1, 5),
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
                            children: const [
                              Text(
                                'Total : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('60', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'On : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('30', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Off : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('45', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "23 Jul 2025 - 11:53",
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
                      width: 110,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 16,
                            spreadRadius: 3,
                            offset: const Offset(1, 5),
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
                            children: const [
                              Text(
                                'Total : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('60', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'On : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('30', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Off : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('45', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "23 Jul 2025 - 11:53",
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

              SizedBox(height: 16),

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
                itemCount: 6,
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
                            "Paprika Grill House Airdrie",
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
                                  Text(
                                    "offline",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(width: 16),

                                  Icon(
                                    Icons.brightness_1_sharp,
                                    color: Colors.red,
                                  ),
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
                                  Text(
                                    "online",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  SizedBox(width: 16),

                                  Icon(
                                    Icons.brightness_1_sharp,
                                    color: Colors.green,
                                  ),
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
        ),
      ),
    );
  }
}
