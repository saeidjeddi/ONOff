
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioServices {
  Future<dynamic> getMethod(String url) async {
     Dio dio = Dio();
  final box = GetStorage();

  dio.options.headers["content-type"] = "application/json";
  dio.options.headers["Authorization"] = "Bearer ${box.read('token')}";
  
  try {
    final response = await dio.get(
      url,
      options: Options(responseType: ResponseType.json),
    );

    return response;
  } on DioException catch (e) {
    if (e.response != null) {
      return e.response; 
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}






Future<dynamic> postMethodFormData(Map<String, dynamic> map, String url) async {
  Dio dio = Dio();
  dio.options.headers["content-type"] = "application/json";

  try {
    final response = await dio.post(
      url,
      data: FormData.fromMap(map),
      options: Options(responseType: ResponseType.json, method: "POST"),
    );

    log("Response: ${response.data}");

    return response;
  } on DioException catch (e) {
    if (e.response != null) {
      return e.response; 
    } else {
      log("DioError: ${e.message}");
      return null;
    }
  } catch (e) {
    log("Unknown error: $e");
    return null;
  }
}











Future<dynamic> getMethodNotToken(String url) async {
     Dio dio = Dio();

  dio.options.headers["content-type"] = "application/json";
  
  try {
    final response = await dio.get(
      url,
      options: Options(responseType: ResponseType.json),
    );

    return response;
  } on DioException catch (e) {
    if (e.response != null) {
      return e.response; 
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

}



