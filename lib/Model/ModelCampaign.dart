// To parse this JSON data, do
//
//     final campaign = campaignFromJson(jsonString);

import 'dart:convert';

Campaignmodel campaignFromJson(String str) => Campaignmodel.fromJson(json.decode(str));

String campaignToJson(Campaignmodel data) => json.encode(data.toJson());

class Campaignmodel {
  Campaignmodel({
    this.resultStatus,
    this.message,
    this.data,
  });

  int? resultStatus;
  dynamic message;
  List<Campaign>? data;

  factory Campaignmodel.fromJson(Map<String, dynamic> json) => Campaignmodel(
    resultStatus: json["resultStatus"],
    message: json["message"],
    data: List<Campaign>.from(json["data"].map((x) => Campaign.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resultStatus": resultStatus,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Campaign {
  Campaign({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.limit,
    required this.currentMoney,
    required this.createdDate,
    required this.city,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.withdrawableMoney
  });
  double withdrawableMoney;
  String id;
  String name;
  String description;
  String photoUrl;
  double limit;
  double currentMoney;
  DateTime createdDate;
  String city;
  String categoryId;
  String userId;
  String userName;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photoUrl: json["photoUrl"],
    limit: json["limit"],
    currentMoney: json["currentMoney"],
    createdDate: DateTime.parse(json["createdDate"]),
    city: json["city"],
    categoryId: json["categoryId"],
    userId: json["userId"],
    withdrawableMoney:json["withdrawableMoney"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "photoUrl": photoUrl,
    "limit": limit,
    "currentMoney": currentMoney,
    "createdDate": createdDate.toIso8601String(),
    "city": city,
    "categoryId": categoryId,
    "userId": userId,
    "userName":userName,
  };
}
