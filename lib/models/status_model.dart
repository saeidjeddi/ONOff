import 'package:get/get.dart';

class PaginatedResponse {
  final Pages pages;
  final int totalPages;
  final int currentPage;
  final List<RestaurantResult> results;

  PaginatedResponse({
    required this.pages,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedResponse(
      pages: Pages.fromJson(json['pages']),
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      results: List<RestaurantResult>.from(
          json['results'].map((x) => RestaurantResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pages': pages.toJson(),
      'totalPages': totalPages,
      'currentPage': currentPage,
      'results': results.map((x) => x.toJson()).toList(),
    };
  }
}

class Pages {
  final String? next;
  final String? previous;

  Pages({
    this.next,
    this.previous,
  });

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      next: json['next'],
      previous: json['previous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'next': next,
      'previous': previous,
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
  final UberEatsCompany? ubereats;
  final FoodHubCompany? foodhub;

  RestaurantCompanies({
    this.justeat,
    this.ubereats,
    this.foodhub,
  });

  factory RestaurantCompanies.fromJson(Map<String, dynamic> json) {
    return RestaurantCompanies(
      justeat: json['justeat'] != null ? JustEatCompany.fromJson(json['justeat']) : null,
      ubereats: json['ubereats'] != null ? UberEatsCompany.fromJson(json['ubereats']) : null,
      foodhub: json['foodhub'] != null ? FoodHubCompany.fromJson(json['foodhub']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'justeat': justeat?.toJson(),
      'ubereats': ubereats?.toJson(),
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

class UberEatsCompany {
  final bool deviceAvailability;
  final UberEatsData? data;

  UberEatsCompany({
    required this.deviceAvailability,
    this.data,
  });

  factory UberEatsCompany.fromJson(Map<String, dynamic> json) {
    return UberEatsCompany(
      deviceAvailability: json['deviceAvailability'],
      data: json['data'] != null ? UberEatsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceAvailability': deviceAvailability,
      'data': data?.toJson(),
    };
  }
}

class UberEatsData {
  final String url;
  final String shopId;
  final String name;
  final bool isOpen;
  final bool isActive;
  final bool isDelivery;
  final bool isPickup;
  final String time;

  UberEatsData({
    required this.url,
    required this.shopId,
    required this.name,
    required this.isOpen,
    required this.isActive,
    required this.isDelivery,
    required this.isPickup,
    required this.time,
  });

  factory UberEatsData.fromJson(Map<String, dynamic> json) {
    return UberEatsData(
      url: json['url'],
      shopId: json['shopId'],
      name: json['name'],
      isOpen: json['isOpen'],
      isActive: json['isActive'],
      isDelivery: json['isDelivery'],
      isPickup: json['isPickup'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'shopId': shopId,
      'name': name,
      'isOpen': isOpen,
      'isActive': isActive,
      'isDelivery': isDelivery,
      'isPickup': isPickup,
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