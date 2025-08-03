
import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/user_info_model.dart';
import 'package:onofflive/services/dio_service.dart';



class UserInfoController extends GetxController {
    RxBool loding = false.obs;


  Rx<UserinfoModel> userInfo = UserinfoModel().obs;

  Future<bool> getUserInfo() async {
    loding.value = true;
    var response = await DioServices().getMethod(ApiUrl.getinfiuser);
    if (response.statusCode == 200) {
      userInfo.value = UserinfoModel.fromJson(response.data);
      loding.value = false;
      return true;
    } else if (response.statusCode == 401) {
      // Get.off(LoginPage());
      loding.value = false;
      return false;
    } else {
      loding.value = false;
      return false;
    }
  }
  }