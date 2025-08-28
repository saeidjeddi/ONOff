import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/controller/foodhub_controller.dart';
import 'package:onofflive/controller/status_controller.dart';
import 'package:onofflive/controller/userInfo_controller.dart';
import 'package:onofflive/views/filter_choice/filter_choice_screen.dart';
import 'package:onofflive/views/login_screen.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SearchType { id, name }

class _HomeScreenState extends State<HomeScreen> {
  final CountController countController = Get.put(CountController());
  final StatusController statusController = Get.put(StatusController());
  final FoodhubController foodhubController = Get.put(FoodhubController());
  UserInfoController userInfoController = Get.put(UserInfoController());
  final TextEditingController searchController = TextEditingController();

  final box = GetStorage();

  SearchType searchType = SearchType.id;




  @override
  void initState() {
    super.initState();
    countController.getCount();
    statusController.getStatusPage();
    userInfoController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _key,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Devices', style: TextStyle(fontSize: 18)),
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

      drawer: Obx(
        () => Drawer(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * .65,
                      height: size.height * .2,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 231, 231),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),

                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          Row(
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    ConstImage.userinfo,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    userInfoController
                                            .userInfo
                                            .value
                                            .username ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: const Color.fromARGB(255, 244, 245, 210),
                            ),

                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.apartment_rounded,
                                    color: Colors.green[900],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  userInfoController
                                          .userInfo
                                          .value
                                          .department ??
                                      '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade300, thickness: 1),

                SizedBox(height: size.height / 10),

                SizedBox(height: size.height * .4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 189, 13, 0),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: size.width * .28,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    box.remove('token');
                    Get.offAll(() => UsrLoginScreen());
                  },
                  child: Text('Log Out'),
                ),

                SizedBox(height: 16),

              ],
            ),
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
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  width: double.infinity,
                  height: size.height / 10,

                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
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
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
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
                                      Text(
                                        countController
                                            .countInfo
                                            .value
                                            .foodhub
                                            .total
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: size.width / 5,
                                        height: size.height / 40,

                                        decoration: BoxDecoration(
                                          color: Colors.red[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),

                                        child: Center(
                                          child: Text(
                                            '● Off(${countController.countInfo.value.foodhub.off.toString()})',
                                            style: TextStyle(
                                              color: Colors.red[900],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: size.width / 5,
                                        height: size.height / 40,

                                        decoration: BoxDecoration(
                                          color: Colors.green[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),

                                        child: Center(
                                          child: Text(
                                            '● On(${countController.countInfo.value.foodhub.onD.toString()})',
                                            style: TextStyle(
                                              color: Colors.green[900],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
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
                            title: 'Feed Me Online',
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
                                      Text(
                                        countController
                                            .countInfo
                                            .value
                                            .feedmeonline
                                            .total
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Container(
                                        width: size.width / 5,
                                        height: size.height / 40,

                                        decoration: BoxDecoration(
                                          color: Colors.red[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),

                                        child: Center(
                                          child: Text(
                                            '● Off(${countController.countInfo.value.feedmeonline.off.toString()})',
                                            style: TextStyle(
                                              color: Colors.red[900],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: size.width / 5,
                                        height: size.height / 40,

                                        decoration: BoxDecoration(
                                          color: Colors.green[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),

                                        child: Center(
                                          child: Text(
                                            '● On(${countController.countInfo.value.feedmeonline.onD.toString()})',
                                            style: TextStyle(
                                              color: Colors.green[900],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(ConstImage.feedmeonlineJpg),
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
                                      Text(
                                        countController
                                            .countInfo
                                            .value
                                            .justeat
                                            .total
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Container(
                                        width: size.width / 5,
                                        height: size.height / 40,

                                        decoration: BoxDecoration(
                                          color: Colors.red[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),

                                        child: Center(
                                          child: Text(
                                            '● Off(${countController.countInfo.value.justeat.off.toString()})',
                                            style: TextStyle(
                                              color: Colors.red[900],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: size.width / 5,
                                        height: size.height / 40,

                                        decoration: BoxDecoration(
                                          color: Colors.green[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),

                                        child: Center(
                                          child: Text(
                                            '● On(${countController.countInfo.value.justeat.onD.toString()})',
                                            style: TextStyle(
                                              color: Colors.green[900],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
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
              ),

              SizedBox(height: size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(


                    children: [


                  Radio<SearchType>(
                    value: SearchType.id,
                    groupValue: searchType,
                    activeColor: const Color.fromARGB(255, 255, 107, 1),
                    onChanged: (value) {
                      setState(() {
                        searchType = value!;
                      });
                    },
                  ),
                  const Text('by Id'),
                  Radio<SearchType>(
                    value: SearchType.name,
                    groupValue: searchType,
                    activeColor: const Color.fromARGB(255, 255, 107, 1),
                    onChanged: (value) {
                      setState(() {
                        searchType = value!;
                      });
                    },
                  ),
                  const Text('by Shop Name'),

                    ],
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                    
                      InkWell(
                        onTap: () {

                          Get.offAll(() => FilterChoiceScreen());
                       
                        },
                        
                        child: Icon(Icons.filter_list, color: Colors.black, size: 32)),



                      ],
                    ),
                  ),
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
                          statusController.page.value = 1;
                          statusController.mealzoId.value =
                              searchController.text;
                          statusController.getStatusMealzoId();
                        } else if (searchType == SearchType.name) {
                          statusController.page.value = 1;
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


              SizedBox(height: size.height / 80),

              if (statusController.loading.value == false) ...[
                if (statusController.restaurantResults.isEmpty &&
                    searchController.text.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(child: Image.asset(ConstImage.noSearch)),
                  ),
                ] else ...[
                  SizedBox(
                    height: size.height * 0.35,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      // shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      itemCount: statusController.restaurantResults.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 300,
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
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                statusController
                                                    .restaurantResults[index]
                                                    .mealzoName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                "Shop Id : ${statusController.restaurantResults[index].mealzoId}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(
                                    color: const Color.fromARGB(
                                      255,
                                      29,
                                      26,
                                      26,
                                    ),
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
                                            // Text('Mealzo'),
                                            // SizedBox(height: size.height / 60),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(32),
                                                        ),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        ConstImage.justeatPng,
                                                      ),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                SizedBox(
                                                  width: 100,
                                                  child: Row(
                                                    children: [
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
                                                                ? Colors
                                                                      .red[100]
                                                                : Colors
                                                                      .green[100],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
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
                                                                    ? Colors
                                                                          .red[900]
                                                                    : Colors
                                                                          .green[900],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ] else ...[
                                                        Container(
                                                          width: 85,
                                                          height: 20,

                                                          decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[100],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                                ),
                                                          ),

                                                          child: Center(
                                                            child: Text(
                                                              '● No Device',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: size.height / 60),

                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(32),
                                                        ),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        ConstImage
                                                            .feedmeonlineJpg,
                                                      ),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(width: 8),

                                                SizedBox(
                                                  width: 100,
                                                  child: Row(
                                                    children: [
                                                      if (statusController
                                                              .restaurantResults[index]
                                                              .companies
                                                              .feedmeonline
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
                                                                        .feedmeonline!
                                                                        .data
                                                                        ?.isOpen ==
                                                                    false
                                                                ? Colors
                                                                      .red[100]
                                                                : Colors
                                                                      .green[100],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                                ),
                                                          ),

                                                          child: Center(
                                                            child: Text(
                                                              statusController
                                                                          .restaurantResults[index]
                                                                          .companies
                                                                          .feedmeonline!
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
                                                                            .feedmeonline!
                                                                            .data
                                                                            ?.isOpen ==
                                                                        false
                                                                    ? Colors
                                                                          .red[900]
                                                                    : Colors
                                                                          .green[900],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ] else ...[
                                                        Container(
                                                          width: 85,
                                                          height: 20,

                                                          decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[100],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                                ),
                                                          ),

                                                          child: Center(
                                                            child: Text(
                                                              '● No Device',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: size.height / 60),

                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(32),
                                                        ),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        ConstImage.foodhubPng,
                                                      ),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),

                                                SizedBox(
                                                  width: 100,
                                                  child: Row(
                                                    children: [
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
                                                                ? Colors
                                                                      .red[100]
                                                                : Colors
                                                                      .green[100],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
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
                                                                    ? Colors
                                                                          .red[900]
                                                                    : Colors
                                                                          .green[900],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ] else ...[
                                                        Container(
                                                          width: 85,
                                                          height: 20,

                                                          decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[100],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                                ),
                                                          ),

                                                          child: Center(
                                                            child: Text(
                                                              '● No Device',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
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
                  ),
                ],
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(child: Image.asset(ConstImage.loade)),
                ),
              ],

              SizedBox(height: size.height / 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (statusController.page.value > 1) ...[
                    InkWell(
                      onTap: () {
                        if (statusController.page.value > 1) {
                          statusController.page.value--;
                          if (searchType == SearchType.name) {
                            statusController.getStatusMealzoName();
                          } else if (searchType == SearchType.id) {
                            statusController.getStatusMealzoId();
                          } else {
                            statusController.getStatusPage();
                          }
                        }
                      },
                      child: Container(
                        width: size.width / 3,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 232, 84, 12),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),

                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_left_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                '${statusController.statusInfo.value.currentPage - 1}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  if (statusController.page.value > 1) ...[
                    Text(
                      '${statusController.statusInfo.value.currentPage} of ${statusController.statusInfo.value.totalPages}',
                    ),
                  ],

                  if (statusController.page.value <
                      statusController.statusInfo.value.totalPages) ...[
                    InkWell(
                      onTap: () {
                        if (statusController.page.value <
                            statusController.statusInfo.value.totalPages) {
                          statusController.page.value++;
                          if (searchType == SearchType.name) {
                            statusController.getStatusMealzoName();
                          } else if (searchType == SearchType.id) {
                            statusController.getStatusMealzoId();
                          } else {
                            statusController.getStatusPage();
                          }
                        }
                      },

                      child: statusController.page.value == 1
                          ? Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                width: size.width / 1.2,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 232, 84, 12),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${statusController.statusInfo.value.currentPage} of ${statusController.statusInfo.value.totalPages}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_right_alt,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: size.width / 3,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 84, 12),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),

                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${statusController.statusInfo.value.currentPage + 1}',
                                      style: TextStyle(color: Colors.white),
                                    ),

                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ],
              ),

              SizedBox(height: 30),

              Container(
                width: double.infinity,
                height: size.height * .22,

                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(16)),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    SizedBox(height: size.height / 60),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(ConstImage.justeatPng),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Text('last update'),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            countController.countInfo.value.justeat.lastTime,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(ConstImage.foodhubPng),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Text('last update'),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            countController.countInfo.value.foodhub.lastTime,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ConstImage.feedmeonlineJpg,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Text('last update'),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            countController.countInfo.value.feedmeonline.lastTime,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

SizedBox(height: size.height *0.1,)
            ],
          ),
        );
      }),
    );
  }
}
