import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/controller/status_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SearchType { id, name }

class _HomeScreenState extends State<HomeScreen> {
  final CountController countController = Get.put(CountController());
  final StatusController statusController = Get.put(StatusController());
  final TextEditingController searchController = TextEditingController();
  SearchType searchType = SearchType.id;

  @override
  void initState() {
    super.initState();
    countController.getCount();
    statusController.getStatusPage();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(ConstImage.group, height: 24, width: 24),
                  const SizedBox(width: 8),
                  const Text('Devices', style: TextStyle(fontSize: 18)),
                ],
              ),
              Image.asset(ConstImage.baner, height: 48, width: 48),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (statusController.loading.value == true) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Devices Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                height: size.height / 4,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Image.asset(
                              ConstImage.totalShop,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Total Shops',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            countController.countInfo.value.allCount.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Image.asset(
                              ConstImage.desktopon,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Total On Devices',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            countController.countInfo.value.allOn.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Image.asset(
                              ConstImage.desktopoff,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Total Off Devices',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            countController.countInfo.value.allOff.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height / 40),

              Container(
                height: size.height / 8,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Mealzo',
                          content: Text('No Data'),
                        );
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(ConstImage.mealzoJpg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Food Hub',
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                child: Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .foodhub
                                          .total
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('On :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .foodhub
                                          .onD
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Off :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .foodhub
                                          .off
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Last Update :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .foodhub
                                          .lastTime,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(ConstImage.foodhubPng),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Uber Eats',
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                child: Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .ubereats
                                          .total
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('On :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .ubereats
                                          .onD
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Off :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .ubereats
                                          .off
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Last Update :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .ubereats
                                          .lastTime,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(ConstImage.ubereatsJpg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Just Eat',
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                child: Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .justeat
                                          .total
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('On :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .justeat
                                          .onD
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Off :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .justeat
                                          .off
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Last Update :'),
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .justeat
                                          .lastTime,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(ConstImage.justeatPng),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height / 40),
Row(
  children: [
    Radio<SearchType>(
      value: SearchType.id,
      groupValue: searchType,
      activeColor: Colors.orange, // رنگ نارنجی
      onChanged: (value) {
        setState(() {
          searchType = value!;
        });
      },
    ),
    const Text(' by Id'),
    Radio<SearchType>(
      value: SearchType.name,
      groupValue: searchType,
      activeColor: Colors.orange, // رنگ نارنجی
      onChanged: (value) {
        setState(() {
          searchType = value!;
        });
      },
    ),
    const Text('by Shop Name'),
  ],
),



              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (value) {
                        if (searchType == SearchType.id) {
                          statusController.mealzoId.value = value;
                          statusController.getStatusMealzoId();
                        } else {
                          statusController.mealzoName.value = value;
                          statusController.getStatusMealzoName();
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Search Shop',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        if (searchType == SearchType.id) {
                          statusController.mealzoId.value =
                              searchController.text;
                          statusController.getStatusMealzoId();
                        } else {
                          statusController.mealzoName.value =
                              searchController.text;
                          statusController.getStatusMealzoName();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: Text('Search'),
                    ),
                  ),
                ],
              ),


              // -------
              SizedBox(height: size.height / 40),
              if (statusController.loading.value == false) ...[
                if (statusController.restaurantResults.isEmpty &&
                    searchController.text.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                       'No results found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ),
                ] else ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: statusController.restaurantResults.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        statusController
                                            .restaurantResults[index]
                                            .mealzoName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),

                                SizedBox(height: size.height / 60),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    0,
                                    32,
                                    0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Mealzo'),
                                          SizedBox(height: size.height / 60),

                                          Text('JustEat'),
                                          SizedBox(height: size.height / 60),

                                          Text('Uber Eat'),
                                          SizedBox(height: size.height / 60),

                                          Text('FoodHub'),
                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 20,

                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),

                                            child: Center(
                                              // child: Text(
                                              //   '● No Service',
                                              //   style: TextStyle(
                                              //     color: Colors.grey[500],
                                              //   ),
                                              // ),
                                            ),
                                          ),

                                          // -----------------------------------------------------------------
                                          SizedBox(height: size.height / 60),

                                          if (statusController
                                                  .restaurantResults[index]
                                                  .companies
                                                  .justeat
                                                  ?.deviceAvailability ==
                                              true) ...[
                                            Container(
                                              width: 40,
                                              height: 20,

                                              decoration: BoxDecoration(
                                                color:
                                                    statusController
                                                            .restaurantResults[index]
                                                            .companies
                                                            .justeat!
                                                            .data
                                                            ?.isOpen ==
                                                        false
                                                    ? Colors.red[100]
                                                    : Colors.green[100],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),

                                              child: Center(
                                                child: Text(
                                                  statusController
                                                              .restaurantResults[index]
                                                              .companies
                                                              .justeat!
                                                              .data
                                                              ?.isOpen ==
                                                          false
                                                      ? '● off'
                                                      : '● On',
                                                  style: TextStyle(
                                                    color:
                                                        statusController
                                                                .restaurantResults[index]
                                                                .companies
                                                                .justeat!
                                                                .data
                                                                ?.isOpen ==
                                                            false
                                                        ? Colors.red[900]
                                                        : Colors.green[900],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ] else ...[
                                            Container(
                                              width: 85,
                                              height: 20,

                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),

                                              child: Center(
                                                child: Text(
                                                  '● No Device',
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],

                                          // --------------------------------------------------------
                                          SizedBox(height: size.height / 60),
                                          if (statusController
                                                  .restaurantResults[index]
                                                  .companies
                                                  .ubereats
                                                  ?.deviceAvailability ==
                                              true) ...[
                                            Container(
                                              width: 40,
                                              height: 20,

                                              decoration: BoxDecoration(
                                                color:
                                                    statusController
                                                            .restaurantResults[index]
                                                            .companies
                                                            .ubereats!
                                                            .data
                                                            ?.isOpen ==
                                                        false
                                                    ? Colors.red[100]
                                                    : Colors.green[100],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),

                                              child: Center(
                                                child: Text(
                                                  statusController
                                                              .restaurantResults[index]
                                                              .companies
                                                              .ubereats!
                                                              .data
                                                              ?.isOpen ==
                                                          false
                                                      ? '● off'
                                                      : '● On',
                                                  style: TextStyle(
                                                    color:
                                                        statusController
                                                                .restaurantResults[index]
                                                                .companies
                                                                .ubereats!
                                                                .data
                                                                ?.isOpen ==
                                                            false
                                                        ? Colors.red[900]
                                                        : Colors.green[900],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ] else ...[
                                            Container(
                                              width: 85,
                                              height: 20,

                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),

                                              child: Center(
                                                child: Text(
                                                  '● No Device',
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],

                                          // -----------------------------------
                                          SizedBox(height: size.height / 60),
                                          if (statusController
                                                  .restaurantResults[index]
                                                  .companies
                                                  .foodhub
                                                  ?.deviceAvailability ==
                                              true) ...[
                                            Container(
                                              width: 40,
                                              height: 20,

                                              decoration: BoxDecoration(
                                                color:
                                                    statusController
                                                            .restaurantResults[index]
                                                            .companies
                                                            .foodhub!
                                                            .data
                                                            ?.isOpen ==
                                                        false
                                                    ? Colors.red[100]
                                                    : Colors.green[100],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),

                                              child: Center(
                                                child: Text(
                                                  statusController
                                                              .restaurantResults[index]
                                                              .companies
                                                              .foodhub!
                                                              .data
                                                              ?.isOpen ==
                                                          false
                                                      ? '● off'
                                                      : '● On',
                                                  style: TextStyle(
                                                    color:
                                                        statusController
                                                                .restaurantResults[index]
                                                                .companies
                                                                .foodhub!
                                                                .data
                                                                ?.isOpen ==
                                                            false
                                                        ? Colors.red[900]
                                                        : Colors.green[900],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ] else ...[
                                            Container(
                                              width: 85,
                                              height: 20,

                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),

                                              child: Center(
                                                child: Text(
                                                  '● No Device',
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(child: Image.asset(ConstImage.loade)),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
