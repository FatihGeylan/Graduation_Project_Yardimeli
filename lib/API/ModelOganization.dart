// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Organizationmodel organizationFromJson(String str) => Organizationmodel.fromJson(json.decode(str));

String organizationToJson(Organizationmodel data) => json.encode(data.toJson());

class Organizationmodel {
  Organizationmodel({
    this.resultStatus,
    this.message,
    this.data,
  });

  int? resultStatus;
  dynamic message;
  List<Organization>? data;

  factory Organizationmodel.fromJson(Map<String, dynamic> json) => Organizationmodel(
    resultStatus: json["resultStatus"],
    message: json["message"],
    data: List<Organization>.from(json["data"].map((x) => Organization.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resultStatus": resultStatus,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}





/*List<Organization> organizationFromJson(String str) =>
    List<Organization>.from(json.decode(str).map((x) => Organization.fromJson(x)));

String userModelToJson(List<Organization> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));*/

class Organization {
  Organization({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.accountNumber,
    required this.balance,
    required this.photoUrl,
  });

  String id;
  String name;
  String shortName;
  String description;
  String accountNumber;
  double balance;
  String photoUrl;

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    id: json["id"],
    name: json["name"],
    shortName: json["shortName"],
    description: json["description"],
    accountNumber: json["accountNumber"],
    balance: json["balance"],
    photoUrl: json["photoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "shortName": shortName,
    "description": description,
    "accountNumber": accountNumber,
    "balance": balance,
    "photoUrl": photoUrl,
  };
}
