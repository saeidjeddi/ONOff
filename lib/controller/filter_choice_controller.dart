import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/filter_choice_model.dart';
import 'package:onofflive/services/dio_service.dart';

class FilterChoiceController extends GetxController {
  RxBool loading = false.obs;
  RxList<FilterChoiceModel> listFilter = RxList();
  Rx<PostInfo> postInfo = PostInfo().obs;
  RxInt page = RxInt(1);
  RxnBool mealzo = RxnBool();
  RxnBool justeat = RxnBool();
  RxnBool foodhub = RxnBool();
  RxnBool feedmeonline = RxnBool();
  RxString mealzoId = ''.obs;


  getStatusFilter() async {
    loading.value = true;
    listFilter.clear();

    var response = await DioServices().getMethodNotToken(
      '${ApiUrl.getFilterChoice}?page=$page&mealzo=$mealzo&foodhub=$foodhub&justeat=$justeat&feedmeonline=$feedmeonline&mealzoId=$mealzoId',
    );

    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {

        listFilter.add(FilterChoiceModel.fromJson(element));
        loading.value = false;
      });

      postInfo.value = PostInfo.fromJson(response.data);
      loading.value = false;
    }






  }
}
