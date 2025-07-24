import 'package:get/get.dart';
import 'package:onoff/components/api_url.dart';
import 'package:onoff/models/status_model.dart';
import 'package:onoff/services/dio_service.dart';

class StatusController extends GetxController {
  RxBool loading = false.obs;
  Rx<PaginatedResponse> statusInfo = PaginatedResponse(
    totalPages: 0,
    currentPage: 0,
    results: [],
  ).obs;

  RxList<RestaurantResult> restaurantResults = <RestaurantResult>[].obs;
  RxInt page = RxInt(1);
  RxString mealzoId = ''.obs;

  getStatusPage() async {
    loading.value = true;

    var response = await DioServices().getMethod(
      '${ApiUrl.getStatus}?page=$page',
    );
    if (response.statusCode == 200) {
      loading.value = true;

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

    var response = await DioServices().getMethod(
      '${ApiUrl.getStatus}?mealzoId=$mealzoId',
    );
    if (response.statusCode == 200) {
      loading.value = true;

      print(page.value);

      statusInfo.value = PaginatedResponse.fromJson(response.data);
      restaurantResults.value = statusInfo.value.results;
    } else {
      Get.snackbar('Error', 'Failed to fetch status data');
    }

    loading.value = false;
  }
}
