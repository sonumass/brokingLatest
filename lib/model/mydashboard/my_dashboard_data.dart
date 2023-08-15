class MyDashboardData {
  MyDashboardData({
    required this.totalProspects,
    required this.noActionTaken,
    required this.cold,
    required this.moderate,
    required this.good,
    required this.partiallyConverted,
    required this.converted,
  });

  MyDashboardData.fromJson(dynamic json) {
    totalProspects = json['totalProspects'] ?? "";
    noActionTaken = json['noActionTaken'] ?? "";
    cold = json['cold'] ?? "";
    moderate = json['moderate'] ?? "";
    good = json['good'] ?? "";
    partiallyConverted = json['partiallyConverted'] ?? "";
    converted = json['converted'] ?? "";
  }

  String totalProspects = "";
  String noActionTaken = "";
  String cold = "";
  String moderate = "";
  String good = "";
  String partiallyConverted = "";
  String converted = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalProspects'] = totalProspects;
    map['noActionTaken'] = noActionTaken;
    map['cold'] = cold;
    map['moderate'] = moderate;
    map['good'] = good;
    map['partiallyConverted'] = partiallyConverted;
    map['converted'] = converted;
    return map;
  }
}
