import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/status_model.dart';
import 'package:onofflive/services/dio_service.dart';

class StatusController extends GetxController {
  RxBool loading = true.obs;
  Rx<PaginatedResponse> statusInfo = PaginatedResponse(
    totalPages: 0,
    currentPage: 0,
    results: [],
  ).obs;

  RxList<RestaurantResult> restaurantResults = <RestaurantResult>[].obs;
  RxInt page = RxInt(1);
  RxString mealzoId = ''.obs;
  RxString mealzoName = ''.obs;

  getStatusPage() async {
    var response = await DioServices().getMethod(
      '${ApiUrl.getStatus}?page=$page',
    );
    if (response.statusCode == 200) {
      print(page.value);

      statusInfo.value = PaginatedResponse.fromJson(response.data);
      restaurantResults.value = statusInfo.value.results;
    } else {
      Get.snackbar('Error', 'Failed to fetch status data');
    }

    loading.value = false;
  }

  getStatusMealzoId() async {
    loading.value = true;
    restaurantResults.clear();
    try {
      var response = await DioServices().getMethod(
        '${ApiUrl.getStatus}?mealzoId=$mealzoId&page=$page',
      );
      if (response.statusCode == 200) {
        print(page.value);
        statusInfo.value = PaginatedResponse.fromJson(response.data);
        restaurantResults.value = statusInfo.value.results;
      } else {
        Get.snackbar('Error', 'Failed to fetch status data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      loading.value = false;
    }
  }





    getStatusMealzoName() async {
    loading.value = true;
    restaurantResults.clear();
    try {
      var response = await DioServices().getMethod(
        '${ApiUrl.getStatus}?mealzoName=$mealzoName&page=$page',
      );
      if (response.statusCode == 200) {
        print(page.value);
        statusInfo.value = PaginatedResponse.fromJson(response.data);
        restaurantResults.value = statusInfo.value.results;
      } else {
        Get.snackbar('Error', 'Failed to fetch status data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      loading.value = false;
    }
  }




}
