
class PaginatedResponse {
  final int totalPages;
  late final int currentPage;
  final List<RestaurantResult> results;

  PaginatedResponse({
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedResponse(
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      results: List<RestaurantResult>.from(
          json['results'].map((x) => RestaurantResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPages': totalPages,
      'currentPage': currentPage,
      'results': results.map((x) => x.toJson()).toList(),
    };
  }
}


class RestaurantResult {
  final int mealzoId;
  final String mealzoName;
  final RestaurantCompanies companies;

  RestaurantResult({
    required this.mealzoId,
    required this.mealzoName,
    required this.companies,
  });

  factory RestaurantResult.fromJson(Map<String, dynamic> json) {
    return RestaurantResult(
      mealzoId: json['mealzoId'],
      mealzoName: json['mealzoName'],
      companies: RestaurantCompanies.fromJson(json['companies']),
    );
  }

  get justeatStatus => null;

  Map<String, dynamic> toJson() {
    return {
      'mealzoId': mealzoId,
      'mealzoName': mealzoName,
      'companies': companies.toJson(),
    };
  }
}

class RestaurantCompanies {
  final JustEatCompany? justeat;
  final FeedMeOnlineCompany? feedmeonline;
  final FoodHubCompany? foodhub;

  RestaurantCompanies({
    this.justeat,
    this.feedmeonline,
    this.foodhub,
  });

  factory RestaurantCompanies.fromJson(Map<String, dynamic> json) {
    return RestaurantCompanies(
      justeat: json['justeat'] != null ? JustEatCompany.fromJson(json['justeat']) : null,
      feedmeonline: json['feedmeonline'] != null ? FeedMeOnlineCompany.fromJson(json['feedmeonline']) : null,
      foodhub: json['foodhub'] != null ? FoodHubCompany.fromJson(json['foodhub']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'justeat': justeat?.toJson(),
      'feedmeonline': feedmeonline?.toJson(),
      'foodhub': foodhub?.toJson(),
    };
  }
}

class JustEatCompany {
  final bool deviceAvailability;
  final JustEatData? data;

  JustEatCompany({
    required this.deviceAvailability,
    this.data,
  });

  factory JustEatCompany.fromJson(Map<String, dynamic> json) {
    return JustEatCompany(
      deviceAvailability: json['deviceAvailability'],
      data: json['data'] != null ? JustEatData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceAvailability': deviceAvailability,
      'data': data?.toJson(),
    };
  }
}

class JustEatData {
  final int shopId;
  final String name;
  final String url;
  final bool isOpen;
  final bool isOpenForPreorder;
  final bool isOpenForOrder;
  final String time;

  JustEatData({
    required this.shopId,
    required this.name,
    required this.url,
    required this.isOpen,
    required this.isOpenForPreorder,
    required this.isOpenForOrder,
    required this.time,
  });

  factory JustEatData.fromJson(Map<String, dynamic> json) {
    return JustEatData(
      shopId: json['shopId'],
      name: json['name'],
      url: json['url'],
      isOpen: json['isOpen'],
      isOpenForPreorder: json['isOpenForPreorder'],
      isOpenForOrder: json['isOpenForOrder'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shopId': shopId,
      'name': name,
      'url': url,
      'isOpen': isOpen,
      'isOpenForPreorder': isOpenForPreorder,
      'isOpenForOrder': isOpenForOrder,
      'time': time,
    };
  }
}

class FeedMeOnlineCompany {
  final bool deviceAvailability;
  final FeedMeOnlineData? data;

  FeedMeOnlineCompany({
    required this.deviceAvailability,
    this.data,
  });

  factory FeedMeOnlineCompany.fromJson(Map<String, dynamic> json) {
    return FeedMeOnlineCompany(
      deviceAvailability: json['deviceAvailability'],
      data: json['data'] != null ? FeedMeOnlineData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceAvailability': deviceAvailability,
      'data': data?.toJson(),
    };
  }
}

class FeedMeOnlineData {
  final String url;
  final String name;
  final bool isOpen;
  final String time;

  FeedMeOnlineData({
    required this.url,
    required this.name,
    required this.isOpen,
    required this.time,
  });

  factory FeedMeOnlineData.fromJson(Map<String, dynamic> json) {
    return FeedMeOnlineData(
      url: json['url'],
      name: json['name'],
      isOpen: json['isOpen'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'isOpen': isOpen,
      'time': time,
    };
  }
}

class FoodHubCompany {
  final bool deviceAvailability;
  final FoodHubData? data;

  FoodHubCompany({
    required this.deviceAvailability,
    this.data,
  });

  factory FoodHubCompany.fromJson(Map<String, dynamic> json) {
    return FoodHubCompany(
      deviceAvailability: json['deviceAvailability'],
      data: json['data'] != null ? FoodHubData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceAvailability': deviceAvailability,
      'data': data?.toJson(),
    };
  }
}

class FoodHubData {
  final String? url;
  final int? shopId;
  final String? name;
  final bool? collection;
  final bool? delivery;
  final bool? isOpen;
  final String? postcode;
  final String? time;

  FoodHubData({
    this.url,
    this.shopId,
    this.name,
    this.collection,
    this.delivery,
    this.isOpen,
    this.postcode,
    this.time,
  });

  factory FoodHubData.fromJson(Map<String, dynamic> json) {
    return FoodHubData(
      url: json['url'],
      shopId: json['shopId'],
      name: json['name'],
      collection: json['collection'],
      delivery: json['delivery'],
      isOpen: json['isOpen'],
      postcode: json['postcode'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'shopId': shopId,
      'name': name,
      'collection': collection,
      'delivery': delivery,
      'isOpen': isOpen,
      'postcode': postcode,
      'time': time,
    };
  }
}