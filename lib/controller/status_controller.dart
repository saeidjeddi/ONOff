import 'package:get/get.dart';
import 'package:onoff/components/api_url.dart';
import 'package:onoff/models/status_model.dart';
import 'package:onoff/services/dio_service.dart';

class StatusController extends GetxController{
    RxBool loding = false.obs;
    Rx<PaginatedResponse> statusInfo = PaginatedResponse(
      pages: Pages(next: null, previous: null),
      totalPages: 0,
      currentPage: 0,
      results: [],
    ).obs;

    RxList<RestaurantResult> restaurantResults = <RestaurantResult>[].obs;

    getStatus() async {
      loding.value = true;

      var response = await DioServices().getMethod(ApiUrl.getStatus);
      if (response.statusCode == 200) {
        statusInfo.value = PaginatedResponse.fromJson(response.data);
        restaurantResults.value = statusInfo.value.results;
      } else {
        Get.snackbar('Error', 'Failed to fetch status data');
      }

      loding.value = false;
    }


}