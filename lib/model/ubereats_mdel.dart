class UbereatsMdel {
  int? mealzo;
  String? url;
  String? shopId;
  String? name;
  bool? isOpen;
  bool? isActive;
  bool? isDelivery;
  bool? isPickup;
  String? time;






  UbereatsMdel();

  UbereatsMdel.fromJson(Map<String, dynamic> element) {
    mealzo = element['mealzo'];
    url = element['url'];
    shopId = element['shopId'];
    name = element['name'];
    isPickup = element['isPickup'];
    isDelivery = element['isDelivery'];
    isOpen = element['isOpen'];
    isActive = element['isActive'];
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