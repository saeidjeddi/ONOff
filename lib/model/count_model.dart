class CountModel {

  final Foodhub foodhub;
  final Justeat justeat;
  final Ubereats ubereats;
  final int allCount;
  final int allOn;
  final int allOff;

  CountModel({
    required this.foodhub,
    required this.justeat,
    required this.ubereats,
    required this.allCount,
    required this.allOn,
    required this.allOff,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) {
    return CountModel(
      foodhub: Foodhub.fromJson(json['foodhub']),
      justeat: Justeat.fromJson(json['justeat']),
      ubereats: Ubereats.fromJson(json['ubereats']),
      allCount: json['all_count'],
      allOn: json['all_on'],
      allOff: json['all_off'],
    );
  }
}

class Foodhub {
  final int total;
  final int onD;
  final int off;
  final String lastTime;

  Foodhub({
    required this.total,
    required this.onD,
    required this.off,
    required this.lastTime,
  });

  factory Foodhub.fromJson(Map<String, dynamic> json) {
    return Foodhub(
      total: json['total'],
      onD: json['on'],
      off: json['off'],
      lastTime: json['last_time'],
    );
  }
}

class Justeat {
  final int total;
  final int onD;
  final int off;
  final String lastTime;

  Justeat({
    required this.total,
    required this.onD,
    required this.off,
    required this.lastTime,
  });

  factory Justeat.fromJson(Map<String, dynamic> json) {
    return Justeat(
      total: json['total'],
      onD: json['on'],
      off: json['off'],
      lastTime: json['last_time'],
    );
  }
}

class Ubereats {
  final int total;
  final int onD;
  final int off;
  final String lastTime;

  Ubereats({
    required this.total,
    required this.onD,
    required this.off,
    required this.lastTime,
  });

  factory Ubereats.fromJson(Map<String, dynamic> json) {
    return Ubereats(
      total: json['total'],
      onD: json['on'],
      off: json['off'],
      lastTime: json['last_time'],
    );
  }
}