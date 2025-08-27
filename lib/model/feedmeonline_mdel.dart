class FeedMeOnlineMdel {
  int? mealzo;
  String? url;
  String? name;
  bool? isOpen;
  String? time;






  FeedMeOnlineMdel();

  FeedMeOnlineMdel.fromJson(Map<String, dynamic> element) {
    mealzo = element['mealzo'];
    url = element['url'];
    name = element['name'];
    isOpen = element['isOpen'];
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