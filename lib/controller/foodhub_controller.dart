import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/foodhob_mdel.dart';
import 'package:onofflive/services/dio_service.dart';

class FoodhubController extends GetxController {
  RxBool loding = false.obs;
  RxList<FoodhobMdel> listFoodhub = RxList();
  Rx<PostInfo> postInfo = PostInfo().obs;
  RxInt page = RxInt(1);
  RxString mealzoId = ''.obs;

  getFoodHubOn() async {
    loding.value = true;

    // Clear the existing list before adding new items
    listFoodhub.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getFoodhub}?page=$page&mealzoId=$mealzoId&isopen=1',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listFoodhub.add(FoodhobMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  getFoodHubOff() async {
    loding.value = true;

    // Clear the existing list before adding new items
    listFoodhub.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getFoodhub}?page=$page&mealzoId=$mealzoId&isopen=0',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listFoodhub.add(FoodhobMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  // Reset method to clear list and reset page

}
