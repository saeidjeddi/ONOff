

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/services/dio_service.dart';



class RgisterController extends GetxController {
  final box = GetStorage();
  RxBool loding = false.obs;

  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

Future<bool> register() async {
  Map<String, dynamic> map = {
    "username": userNameEditingController.text,
    "password": passwordEditingController.text,
  };

  var response = await DioServices().postMethodFormData(map, ApiUrl.getTokenUrl);
  loding.value = false;
  if (response.statusCode == 200) {
    loding.value = true;
    box.write('isLoggedIn', true);  
    box.write('token', response.data['access']);
    box.write('refresh', response.data['refresh']);
    return true;
  } else if (response.statusCode == 400) {
    loding.value = false;
    return false;
  } else if (response.statusCode == 401) {
    loding.value = false;
    // -----------------------------------
      Get.closeAllSnackbars();

Get.rawSnackbar(
  titleText: const Text(
    "Error",
    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
  ),
  messageText: Text(
    "${response.data['detail']}",
    style: const TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.grey[900]!,
  icon: const Icon(Icons.error_outline, color: Colors.redAccent),
  snackPosition: SnackPosition.BOTTOM,
  margin: const EdgeInsets.all(16),
  borderRadius: 12,
  duration: const Duration(seconds: 3),
  animationDuration: const Duration(milliseconds: 400),
);
    // -----------------------------------
    loding.value = false;
    return false;
  } 

  // Ensure a boolean is always returned if none of the above conditions are met
  return false;
}

}