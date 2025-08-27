import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/feedmeonline_mdel.dart';
import 'package:onofflive/services/dio_service.dart';

class FeedMeOnlineController extends GetxController {
  RxBool loding = false.obs;
  RxList<FeedMeOnlineMdel> listFeedme = RxList();
  Rx<PostInfo> postInfo = PostInfo().obs;
  RxInt page = RxInt(1);
  RxString mealzoId = ''.obs;

  getFeedMeOnline() async {
    loding.value = true;

    listFeedme.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getFeedMeOnline}?page=$page&mealzoId=$mealzoId&isopen=1',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listFeedme.add(FeedMeOnlineMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  getFeedMeOnlineOff() async {
    loding.value = true;

    // Clear the existing list before adding new items
    listFeedme.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getFeedMeOnline}?page=$page&mealzoId=$mealzoId&isopen=0',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listFeedme.add(FeedMeOnlineMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  // Reset method to clear list and reset page
}
