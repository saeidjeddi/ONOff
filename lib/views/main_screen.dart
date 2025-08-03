import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/components/widgets.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/controller/status_controller.dart';
import 'package:onofflive/controller/userInfo_controller.dart';
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
              Row(
                children: [
                  Image.asset(ConstImage.group, height: 24, width: 24),
                  const SizedBox(width: 6),
                  const Text('Devices', style: TextStyle(fontSize: 18)),
                ],
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  ConstImage.userinfo,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.fill,
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

                SizedBox(height: size.height / 45),

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
                    myLaunchUrl(ApiUrl.getWebsite);
                  },
                ),
                Divider(color: Colors.grey.shade300, thickness: 1),
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

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(width: 300, child: Text('Version : 0.0.1')),
                ),
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
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Devices Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                height: size.height / 10,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(
                        255,
                        136,
                        0,
                        1,
                      ).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Image.asset(
                          ConstImage.totalShop,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Total  Devices',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    Obx(
                      () => Text(
                        countController.countInfo.value.allCount.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height / 90),

              Container(
                height: size.height / 10,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        116,
                        255,
                        52,
                      ).withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Image.asset(
                          ConstImage.desktopon,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Total On Devices',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Obx(
                      () => Text(
                        countController.countInfo.value.allOn.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height / 90),

              Container(
                height: size.height / 10,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        255,
                        0,
                        0,
                      ).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Image.asset(
                          ConstImage.desktopoff,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Total Off Devices',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Obx(
                      () => Text(
                        countController.countInfo.value.allOff.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height / 40),

              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
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
                                          '● On(${countController.countInfo.value.foodhub.off.toString()})',
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

                              Text(
                                countController.countInfo.value.foodhub.lastTime
                                    .toString(),
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
                                    Text(
                                      countController
                                          .countInfo
                                          .value
                                          .ubereats
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
                                          '● On(${countController.countInfo.value.ubereats.off.toString()})',
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
                                          '● On(${countController.countInfo.value.ubereats.onD.toString()})',
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

                              Text(
                                countController
                                    .countInfo
                                    .value
                                    .ubereats
                                    .lastTime
                                    .toString(),
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
                                          '● On(${countController.countInfo.value.justeat.off.toString()})',
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

                              Text(
                                countController.countInfo.value.justeat.lastTime
                                    .toString(),
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

              SizedBox(height: size.height / 40),
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
                      child: Image.asset(ConstImage.noSearch)
                    ),
                  ),
                ] else ...[
                 
                  SizedBox(
                    height: size.height * .25, 
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
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
                                                  width: 24,
                                                  height: 24,
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
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(32),
                                                        ),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        ConstImage.ubereatsJpg,
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
                                                  width: 24,
                                                  height: 24,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (statusController.page.value > 1) ...[
                    InkWell(
                      onTap: () {
                        if (statusController.page.value > 1) {
                          statusController.page.value--;
                          statusController.getStatusPage();
                        }
                      },
                      child: Image.asset(ConstImage.backPage),
                    ),
                  ],

                  if (statusController.page.value <
                      statusController.statusInfo.value.totalPages) ...[
                    InkWell(
                      onTap: () {
                        if (statusController.page.value <
                            statusController.statusInfo.value.totalPages) {
                          statusController.page.value++;
                          statusController.getStatusPage();
                        }
                      },

                      child: statusController.page.value == 1
                          ? Padding(
                              padding: const EdgeInsets.only(left: 32),
                              child: Image.asset(ConstImage.nextPageB),
                            )
                          : Image.asset(ConstImage.nextPage),
                    ),
                  ],
                ],
              ),

              SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }
}
