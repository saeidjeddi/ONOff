import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/ubereats_mdel.dart';
import 'package:onofflive/services/dio_service.dart';

class UberetsController extends GetxController {
  RxBool loding = false.obs;
  RxList<UbereatsMdel> listUber = RxList();
  Rx<PostInfo> postInfo = PostInfo().obs;
  RxInt page = RxInt(1);
  RxString mealzoId = ''.obs;

  getUberOn() async {
    loding.value = true;

    listUber.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getUbereats}?page=$page&mealzoId=$mealzoId&isopen=1',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listUber.add(UbereatsMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  getUberOff() async {
    loding.value = true;

    // Clear the existing list before adding new items
    listUber.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getUbereats}?page=$page&mealzoId=$mealzoId&isopen=0',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listUber.add(UbereatsMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  // Reset method to clear list and reset page

}
