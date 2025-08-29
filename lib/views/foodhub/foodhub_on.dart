import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/components/widgets.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/controller/foodhub_controller.dart';
import 'package:onofflive/controller/userInfo_controller.dart';
import 'package:onofflive/views/filter_choice/filter_choice_screen.dart' show FilterChoiceScreen;
import 'package:onofflive/views/login_screen.dart';
import 'package:onofflive/views/main_screen.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class FoodhubOn extends StatefulWidget {
  const FoodhubOn({super.key});

  @override
  State<FoodhubOn> createState() => _FoodhubOnState();
}

class _FoodhubOnState extends State<FoodhubOn> {
  final UserInfoController userInfoController = Get.put(UserInfoController());
  final FoodhubController getfoodhubController = Get.put(FoodhubController());
  final CountController countController = Get.put(CountController());

  final TextEditingController searchController = TextEditingController();

  final box = GetStorage();

  SearchType searchType = SearchType.id;

  bool itemChecksAll = true;
  bool itemChecks = false;

  @override
  void initState() {
    super.initState();
    // Initial data load should not live in build to avoid reloads on focus/resize
    getfoodhubController.getFoodHubOn();
    userInfoController.getUserInfo();
    countController.getCount();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
              IconButton(
                onPressed: () => Get.offAll(() => FilterChoiceScreen()),
                icon: Icon(Icons.arrow_back),
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
        if (getfoodhubController.loding.value == true) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (value) {
                          getfoodhubController.page.value = 1;
                          getfoodhubController.mealzoId.value = value;
                          getfoodhubController.getFoodHubOn();
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
                          getfoodhubController.page.value = 1;
                          getfoodhubController.mealzoId.value =
                              searchController.text;
                          getfoodhubController.getFoodHubOn();
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
              ),

              SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: size.height * .07,

                  decoration: BoxDecoration(
                    color: Colors.white,
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

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          image: DecorationImage(
                            image: AssetImage(ConstImage.foodhubPng),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text('Total On : '),
                      Text('${countController.countInfo.value.foodhub.onD}'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: getfoodhubController.listFoodhub.length,
                itemBuilder: (context, index) {
                  final item = getfoodhubController.listFoodhub[index];

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width * .4,
                                      child: Text(
                                        item.name ?? "",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),


               Text("Id : ${item.mealzo}" , style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),)                                  ],
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () {
                                    myLaunchUrl(
                                      getfoodhubController
                                          .listFoodhub[index]
                                          .url!,
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.link,
                                        size: 14,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "View website",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    const Icon(Icons.inventory_2, size: 12),
                                    const SizedBox(width: 4),
                                    Text('Collection : '),
                                    SizedBox(width: 8),
                                    Text(
                                      item.collection == true
                                          ? 'Open'
                                          : 'Close',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.delivery_dining, size: 12),
                                    const SizedBox(width: 4),

                                    Text('Delivery : '),
                                    SizedBox(width: 8),
                                    Text(
                                      item.delivery == true ? 'Open' : 'Close',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: item.isOpen == true
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 4),
                                    Text('Status : '),
                                    SizedBox(width: 8),
                                    Text(
                                      item.isOpen == true ? "Open" : "Closed",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Text(
                                //   item.time != null
                                //       ? DateFormat(
                                //           "dd,MMM/yyyy - HH:mm",
                                //         ).format(
                                //           DateTime.parse(item.time!).toLocal(),
                                //         )
                                //       : "",
                                //   style: const TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.grey,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 30),
              if (getfoodhubController.postInfo.value.next != null) ...[
                if (getfoodhubController.postInfo.value.currentPage! == 1) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        getfoodhubController.page.value++;
                        getfoodhubController.getFoodHubOn();
                      },
                      child: Container(
                        width: double.infinity,
                        height: size.height * .04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.deepOrange,
                        ),

                        child: Center(
                          child: Text(
                            'page: ${getfoodhubController.postInfo.value.currentPage} Of ${getfoodhubController.postInfo.value.totalPages} >',
                            style: TextStyle(
                              color:  Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (getfoodhubController.page.value > 1) ...[
                          InkWell(
                            onTap: () {
                              if (getfoodhubController.page.value > 1) {
                                getfoodhubController.page.value--;
                                getfoodhubController.getFoodHubOn();
                              }
                            },
                            child: Container(
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
                                    Icon(
                                      Icons.arrow_left_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '${getfoodhubController.postInfo.value.currentPage! - 1}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],

                        if (getfoodhubController.page.value > 1) ...[
                          Text(
                            '${getfoodhubController.postInfo.value.currentPage} of ${getfoodhubController.postInfo.value.totalPages}',
                          ),
                        ],

                        if (getfoodhubController.page.value <
                            getfoodhubController
                                .postInfo
                                .value
                                .totalPages!) ...[
                          InkWell(
                            onTap: () {
                              if (getfoodhubController.page.value <
                                  getfoodhubController
                                      .postInfo
                                      .value
                                      .totalPages!) {
                                getfoodhubController.page.value++;
                                getfoodhubController.getFoodHubOn();
                              }
                            },

                            child: getfoodhubController.page.value == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Container(
                                      width: size.width / 1.2,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          232,
                                          84,
                                          12,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${getfoodhubController.postInfo.value.currentPage} of ${getfoodhubController.postInfo.value.totalPages}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
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
                                      color: const Color.fromARGB(
                                        255,
                                        232,
                                        84,
                                        12,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),

                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${getfoodhubController.postInfo.value.currentPage! + 1}',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
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
                  ),
                ],
              ],
              SizedBox(height: 80),
            ],
          ),
        );
      }),
    );
  }
}

class $ {}
