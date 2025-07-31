import 'package:get/get.dart';
import 'package:onofflive/components/api_url.dart';
import 'package:onofflive/model/count_model.dart';
import 'package:onofflive/services/dio_service.dart';

class CountController extends GetxController {
  RxBool loading = false.obs;

  Rx<CountModel> countInfo = CountModel(
    foodhub: Foodhub(total: 0, onD: 0, off: 0, lastTime: ''),
    justeat: Justeat(total: 0, onD: 0, off: 0, lastTime: ''),
    ubereats: Ubereats(total: 0, onD: 0, off: 0, lastTime: ''),
    allCount: 0,
    allOn: 0,
    allOff: 0,
  ).obs;

  Future<bool> getCount() async {
    loading.value = true;

    var response = await DioServices().getMethod(ApiUrl.getCount);
    if (response.statusCode == 200) {
      countInfo.value = CountModel.fromJson(response.data);
      loading.value = false;
      return true;
    } else {
      loading.value = false;
      return false;
    }
  }
}
