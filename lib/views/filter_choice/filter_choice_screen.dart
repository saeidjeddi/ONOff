import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/controller/filter_choice_controller.dart';
import 'package:onofflive/controller/userInfo_controller.dart';
import 'package:onofflive/views/feedmeonline/feedmeonline_off.dart';
import 'package:onofflive/views/feedmeonline/feedmeonline_on.dart';
import 'package:onofflive/views/foodhub/foodhub_off.dart';
import 'package:onofflive/views/foodhub/foodhub_on.dart';
import 'package:onofflive/views/justeat/justeat_off.dart';
import 'package:onofflive/views/justeat/justeat_on.dart';
import 'package:onofflive/views/login_screen.dart';
import 'package:onofflive/views/main_screen.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class FilterChoiceScreen extends StatefulWidget {
  const FilterChoiceScreen({super.key});

  @override
  State<FilterChoiceScreen> createState() => _FilterChoiceScreenState();
}

enum SearchType { id, name }

class _FilterChoiceScreenState extends State<FilterChoiceScreen> {
  final CountController countController = Get.put(CountController());

  UserInfoController userInfoController = Get.put(UserInfoController());
  final TextEditingController searchController = TextEditingController();
  FilterChoiceController filterChoiceController = Get.put(
    FilterChoiceController(),
  );

  final box = GetStorage();

  SearchType searchType = SearchType.id;

  bool? justeat;
  bool? foodhub;
  bool? feedmeonline;
  bool filtrerShow = true;

  @override
  void initState() {
    super.initState();
    countController.getCount();
    userInfoController.getUserInfo();
    filterChoiceController.getStatusFilter();
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
              InkWell(
                onTap: () {
                  Get.offAll(() => HomeScreen());
                },
                child: Icon(Icons.arrow_back, color: Colors.black),
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
        if (filterChoiceController.loading.value == true) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              
              Container(
                width: double.infinity,
                height: size.height * .22,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
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
              SizedBox(height: size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              filtrerShow = !filtrerShow;
                            });
                          },

                          child: Icon(
                            Icons.filter_list,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),



                      ],
                    ),
                  ),


                 Padding(
                   padding: const EdgeInsets.only(right: 16),
                   child: InkWell(
                     onTap: () {








                          Get.bottomSheet(
                            Container(
                              width: double.infinity,
                              height: size.height / 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: ListView(
                                children: [
                                  SizedBox(height: 6),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [Icon(Icons.tune)]),
                                  ),
                                  ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              ConstImage.foodhubPng,
                                              width: 30,
                                              height: 30,
                                            ),
                                            SizedBox(width: 16),
                                            Text("FoodHub"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: [
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                
                                                Get.offAll(() => FoodhubOn());
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "On",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 16),

                                            GestureDetector(
                                              onTap: () {
                                                Get.offAll(() => FoodhubOff());
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "off",
                                                      style: TextStyle(
                                                        color: Colors.red[900],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
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

                                            Text("feedmeonline"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: [
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.offAll(() => FeedMeOnlineOn());
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "on",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 16),

                                            GestureDetector(
                                              onTap: () {
                                                Get.offAll(() => FeedMeOnlineOff());
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "off",
                                                      style: TextStyle(
                                                        color: Colors.red[900],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    ConstImage.justeatPng,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 16),

                                            Text("Just Eats"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: [
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.offAll(() => JustEatOn());
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "on",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 16),

                                            GestureDetector(
                                              onTap: () {
                                                Get.offAll(()=> JustEatOff());
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(16),
                                                      ),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "off",
                                                      style: TextStyle(
                                                        color: Colors.red[900],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );




                      
                    
                     },
                     child: Icon(Icons.filter_alt_rounded, color: Colors.black, size: 32),
                   ),
                 ),

                ],
              ),

             Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (value) {
                          filterChoiceController.page.value = 1;
                          filterChoiceController.mealzoId.value = value;
                          filterChoiceController.getStatusFilter();
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
                          filterChoiceController.page.value = 1;
                          filterChoiceController.mealzoId.value =
                              searchController.text;
                          filterChoiceController.getStatusFilter();
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

              // -------
              SizedBox(height: size.height / 80),

              if (filtrerShow) ...[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text("justeat_on"),
                        value: justeat == true,
                        onChanged: (val) {
                          setState(() {
                            justeat = val == true ? true : null;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("justeat_off"),
                        value: justeat == false,
                        onChanged: (val) {
                          setState(() {
                            justeat = val == true ? false : null;
                          });
                        },
                      ),
                      Divider(),
                      CheckboxListTile(
                        title: Text("foodhub_on"),
                        value: foodhub == true,
                        onChanged: (val) {
                          setState(() {
                            foodhub = val == true ? true : null;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("foodhub_off"),
                        value: foodhub == false,
                        onChanged: (val) {
                          setState(() {
                            foodhub = val == true ? false : null;
                          });
                        },
                      ),
                      Divider(),
                      CheckboxListTile(
                        title: Text("feedmeonline_on"),
                        value: feedmeonline == true,
                        onChanged: (val) {
                          setState(() {
                            feedmeonline = val == true ? true : null;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("feedmeonline_off"),
                        value: feedmeonline == false,
                        onChanged: (val) {
                          setState(() {
                            feedmeonline = val == true ? false : null;
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(),
                      ),

                      SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          filterChoiceController.page.value = 1;
                          filterChoiceController.justeat.value = justeat;
                          filterChoiceController.foodhub.value = foodhub;
                          filterChoiceController.feedmeonline.value =
                              feedmeonline;
                          filterChoiceController.getStatusFilter();
                          filtrerShow = false;

                        },
                        child: Text("Apply Filters"),
                      ),
                    ],
                  ),
                ),
                // Show filter options
              ],

              SizedBox(height: size.height / 80),

              if (filterChoiceController.loading.value == false) ...[
                if (filterChoiceController.listFilter.isEmpty && searchController.text.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(child: Image.asset(ConstImage.noSearch)),
                  ),
                ] else if (filterChoiceController.listFilter.isEmpty) ...[
 Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(child: Image.asset(ConstImage.noSearch)),
                  ),
                ] else ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filterChoiceController.listFilter.length,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * .6,
                                        child: Text(
                                          filterChoiceController
                                              .listFilter[index]
                                              .mealzoName
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Spacer(),
                                    ],


                                  ),
                                ),
                               Text('Mealzo Id: ${filterChoiceController.listFilter[index].mealzoId}'),
                               Text('Mealzo Postcode: ${filterChoiceController.listFilter[index].mealzoPostcode}'),

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

              SizedBox(height: 30),




              if (filterChoiceController.postInfo.value.next != null) ...[
                if (filterChoiceController.postInfo.value.currentPage! == 1) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        filterChoiceController.page.value++;
                        filterChoiceController.getStatusFilter();
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
                            'page: ${filterChoiceController.postInfo.value.currentPage} Of ${filterChoiceController.postInfo.value.totalPages} >',
                            style: TextStyle(
                              color: Colors.white,
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
                        if (filterChoiceController.page.value > 1) ...[
                          InkWell(
                            onTap: () {
                              if (filterChoiceController.page.value > 1) {
                                filterChoiceController.page.value--;
                                filterChoiceController.getStatusFilter();
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
                                      '${filterChoiceController.postInfo.value.currentPage! - 1}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],

                        if (filterChoiceController.page.value > 1) ...[
                          Text(
                            '${filterChoiceController.postInfo.value.currentPage} of ${filterChoiceController.postInfo.value.totalPages}',
                          ),
                        ],

                        if (filterChoiceController.page.value <
                            filterChoiceController
                                .postInfo
                                .value
                                .totalPages!) ...[
                          InkWell(
                            onTap: () {
                              if (filterChoiceController.page.value <
                                  filterChoiceController
                                      .postInfo
                                      .value
                                      .totalPages!) {
                                filterChoiceController.page.value++;
                                filterChoiceController.getStatusFilter();
                              }
                            },

                            child: filterChoiceController.page.value == 1
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
                                              '${filterChoiceController.postInfo.value.currentPage} of ${filterChoiceController.postInfo.value.totalPages}',
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
                                            '${filterChoiceController.postInfo.value.currentPage! + 1}',
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

              SizedBox(height: 60),
            ],
          ),
        );
      }),
    );
  }
}
