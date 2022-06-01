import 'dart:convert';

class User{
  // String email;
  String accessToken;

  User({required this.accessToken});

  factory User.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return User(
      // email: json['email'],
      accessToken: json['data']['accessToken'],
    );

  }

  void printAttributes() {
    // print("email: ${this.email}\n");
    print("token: ${this.accessToken}\n");
  }

}