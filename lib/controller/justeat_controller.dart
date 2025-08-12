import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/justeat_mdel.dart';
import 'package:onofflive/services/dio_service.dart';

class JusteatController extends GetxController {
  RxBool loding = false.obs;
  RxList<JusteatMdel> listjust = RxList();
  Rx<PostInfo> postInfo = PostInfo().obs;
  RxInt page = RxInt(1);

  getJustOn() async {
    loding.value = true;

    listjust.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getJusteat}?page=$page&isopen=1',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listjust.add(JusteatMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  getJustOff() async {
    loding.value = true;

    // Clear the existing list before adding new items
    listjust.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getJusteat}?page=$page&isopen=0',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listjust.add(JusteatMdel.fromJson(element));
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }

  // Reset method to clear list and reset page

}
