class FoodhobMdel {
  int? mealzo;
  String? url;
  int? shopId;
  String? name;
  bool? collection;
  bool? delivery;
  bool? isOpen;
  String? postcode;
  String? time;

  FoodhobMdel();

  FoodhobMdel.fromJson(Map<String, dynamic> element) {
    mealzo = element['mealzo'];
    url = element['url'];
    shopId = element['shopId'];
    name = element['name'];
    collection = element['collection'];
    delivery = element['delivery'];
    isOpen = element['isOpen'];
    postcode = element['postcode'];
    time = element['time'];
  }
}


class PostInfo {
  int? totalPages;
  int? currentPage;
  String? next;
  String? previous;

  PostInfo({this.totalPages,this.currentPage, this.next, this.previous});

factory PostInfo.fromJson(Map<String, dynamic> element) {
  return PostInfo(
    totalPages: element['totalPages'],
    currentPage: element['currentPage'],
    next: element['pages']['next'],
    previous: element['pages']['previous'],
  );
}
  
}