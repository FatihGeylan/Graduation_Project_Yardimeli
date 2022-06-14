import 'dart:convert';

import 'ModelCampaign.dart';


Usermodel userFromJson(String str) => Usermodel.fromJson(json.decode(str));

String userToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    this.resultStatus,
    this.message,
    this.data,
  });

  int? resultStatus;
  dynamic message;
  List<User>? data;

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    resultStatus: json["resultStatus"],
    message: json["message"],
    data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resultStatus": resultStatus,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class User {
  User({
    required this.Id,
    required this.Email,
    required this.UserName,
    required this.City,
    required this.Balance,
    required this.FirstName,
    required this.LastName,
  });

  String Id;
  String Email;
  String UserName;
  String City;
  double Balance;
  String FirstName;
  String LastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    Id: json["Id"],
    Email: json["Email"],
    UserName: json["UserName"],
    City: json["City"],
    Balance: json["Balance"],
    FirstName: json["FirstName"],
    LastName: json["LastName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Email": Email,
    "UserName": UserName,
    "City": City,
    "Balance": Balance,
    "FirstName": FirstName,
    "LastName": LastName,
  };
}