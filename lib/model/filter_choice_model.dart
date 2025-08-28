class FilterChoiceModel {
  int? mealzoId;
  String? mealzoName;
  String? mealzoPostcode;

  FilterChoiceModel();

  FilterChoiceModel.fromJson(Map<String, dynamic> element) {
    mealzoId = element['mealzoId'];
    mealzoName = element['mealzoName'];
    mealzoPostcode = element['mealzoPostcode'];
  }
}


class PostInfo {
  int? totalPages;
  int? currentPage;  
  int? count;  
  String? next;
  String? previous;

  PostInfo({this.totalPages,this.currentPage,this.count, this.next, this.previous});

factory PostInfo.fromJson(Map<String, dynamic> element) {
  return PostInfo(
    totalPages: element['totalPages'],
    currentPage: element['currentPage'],
    count: element['count'],
    next: element['pages']['next'],
    previous: element['pages']['previous'],
  );
}
  
}
