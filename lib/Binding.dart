import 'package:get/get.dart';
import 'package:onofflive/controller/count_controller.dart';
import 'package:onofflive/controller/rgister_controller.dart';
import 'package:onofflive/controller/status_controller.dart';
import 'package:onofflive/controller/userInfo_controller.dart';



class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => UserInfoController());
    Get.put(() => CountController());
    Get.put(() => RgisterController());
    Get.put(() => StatusController());
  }
}