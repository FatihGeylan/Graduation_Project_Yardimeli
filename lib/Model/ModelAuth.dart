import 'dart:convert';


// class User {
//   User({
//     required this.email,
//     required this.userName,
//     required this.firstName,
//     required this.lastName,
//     required this.city,
//   });
//
//   String email;
//   String userName;
//   String firstName;
//   String lastName;
//   String city;
//   String accessToken;
//
//   factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
//     id: json["id"],
//     name: json["name"],
//     description: json["description"],
//     photoUrl: json["photoUrl"],
//     limit: json["limit"],
//     currentMoney: json["currentMoney"],
//     isDone: json["isDone"],
//     isVerified: json["isVerified"],
//     createdDate: DateTime.parse(json["createdDate"]),
//     city: json["city"],
//     isRejected: json["isRejected"],
//     categoryId: json["categoryId"],
//     userId: json["userId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "description": description,
//     "photoUrl": photoUrl,
//     "limit": limit,
//     "currentMoney": currentMoney,
//     "isDone": isDone,
//     "isVerified": isVerified,
//     "createdDate": createdDate.toIso8601String(),
//     "city": city,
//     "isRejected": isRejected,
//     "categoryId": categoryId,
//     "userId": userId,
//   };
// }
class Auth{
  // String email;
  String accessToken;
  Auth({required this.accessToken});

  factory Auth.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    return Auth(
      // email: json['email'],
      accessToken: json['data']['accessToken'],
    );
  }
  void printAttributes() {
    // print("email: ${this.email}\n");
    print("token: ${this.accessToken}\n");
  }
}