import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/foodhob_mdel.dart';
import 'package:onofflive/services/dio_service.dart';

class FoodhubController extends GetxController {
  RxBool loding = false.obs;
  RxList<FoodhobMdel> listFoodhub = RxList();
  Rx<PostInfo> postInfo = PostInfo().obs;
  RxInt page = RxInt(1);

  getFoodHub() async {
    loding.value = true;

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getFoodhub}?page=$page',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        listFoodhub.add(FoodhobMdel.fromJson(element));
        print(response.data['results']);
        loding.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loding.value = false;
    }
  }
}
