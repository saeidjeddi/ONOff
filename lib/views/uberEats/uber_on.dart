import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/components/widgets.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/controller/uberets_controller.dart';
import 'package:onofflive/controller/userInfo_controller.dart';
import 'package:onofflive/views/login_screen.dart';
import 'package:onofflive/views/main_screen.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class UberEatsOn extends StatefulWidget {
  const UberEatsOn({super.key});

  @override
  State<UberEatsOn> createState() => _UberEatsOnState();
}

class _UberEatsOnState extends State<UberEatsOn> {
  final UserInfoController userInfoController = Get.put(UserInfoController());
  final UberetsController getUberController = Get.put(UberetsController());
  final CountController countController = Get.put(CountController());

  final TextEditingController searchController = TextEditingController();

  final box = GetStorage();

  SearchType searchType = SearchType.id;

  bool itemChecksAll = true;
  bool itemChecks = false;

  @override
  void initState() {
    super.initState();
    getUberController.getUberOn();
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
                onPressed: () => Get.offAll(() => HomeScreen()),
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

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(width: 300, child: Text('Version : 0.0.2')),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Obx(() {
        if (getUberController.loding.value == true) {
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
                          getUberController.page.value = 1;
                          getUberController.mealzoId.value = value;
                          getUberController.getUberOn();
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
                          getUberController.page.value = 1;
                          getUberController.mealzoId.value =
                              searchController.text;
                          getUberController.getUberOn();
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
                            image: AssetImage(ConstImage.ubereatsJpg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text('Total On : '),
                      Text('${countController.countInfo.value.ubereats.onD}'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 1,
                ),
                itemCount: getUberController.listUber.length,
                itemBuilder: (context, index) {
                  final item = getUberController.listUber[index];

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
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[100],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mealzo Id",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  item.mealzo.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // محتوا
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () {
                                    myLaunchUrl(
                                      getUberController.listUber[index].url!,
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
                                        "View on website",
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
                                    Text('collection : '),
                                    SizedBox(width: 8),
                                    Text(
                                      item.isPickup == true ? 'Open' : 'Close',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.delivery_dining, size: 12),
                                    const SizedBox(width: 4),

                                    Text('delivery : '),
                                    SizedBox(width: 8),
                                    Text(
                                      item.isDelivery == true
                                          ? 'Open'
                                          : 'Close',
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
                                    Text('isOpen : '),
                                    SizedBox(width: 8),
                                    Text(
                                      item.isOpen == true ? "Open" : "Closed",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  item.time != null
                                      ? DateFormat(
                                          "dd,MMM/yyyy - HH:mm",
                                        ).format(
                                          DateTime.parse(item.time!).toLocal(),
                                        )
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
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
              if (getUberController.postInfo.value.next != null) ...[
                if (getUberController.postInfo.value.currentPage! == 1) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        getUberController.page.value++;
                        getUberController.getUberOn();
                      },
                      child: Container(
                        width: double.infinity,
                        height: size.height * .04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.deepOrange,
                        ),

                        child: Center(
                          child: Text(
                            'page: ${getUberController.postInfo.value.currentPage} Of ${getUberController.postInfo.value.totalPages} >',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 214, 211, 211),
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
                        if (getUberController.page.value > 1) ...[
                          InkWell(
                            onTap: () {
                              if (getUberController.page.value > 1) {
                                getUberController.page.value--;
                                getUberController.getUberOn();
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
                                      '${getUberController.postInfo.value.currentPage! - 1}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],

                        if (getUberController.page.value > 1) ...[
                          Text(
                            '${getUberController.postInfo.value.currentPage} of ${getUberController.postInfo.value.totalPages}',
                          ),
                        ],

                        if (getUberController.page.value <
                            getUberController.postInfo.value.totalPages!) ...[
                          InkWell(
                            onTap: () {
                              if (getUberController.page.value <
                                  getUberController
                                      .postInfo
                                      .value
                                      .totalPages!) {
                                getUberController.page.value++;
                                getUberController.getUberOn();
                              }
                            },

                            child: getUberController.page.value == 1
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
                                              '${getUberController.postInfo.value.currentPage} of ${getUberController.postInfo.value.totalPages}',
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
                                            '${getUberController.postInfo.value.currentPage! + 1}',
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
