class JusteatMdel {
  int? mealzo;
  int? shopId;
  String? name;
  String? url;
  bool? isOpen;
  bool? isOpenForPreorder;
  bool? isOpenForOrder;
  bool? isTemporaryOffline;
  String? time;



  JusteatMdel();

  JusteatMdel.fromJson(Map<String, dynamic> element) {
    mealzo = element['mealzo'];
    url = element['url'];
    shopId = element['shopId'];
    name = element['name'];
    isOpenForPreorder = element['isOpenForPreorder'];
    isOpenForOrder = element['isOpenForOrder'];
    isOpen = element['isOpen'];
    isTemporaryOffline = element['isTemporaryOffline'];
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