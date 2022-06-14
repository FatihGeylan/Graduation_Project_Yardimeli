import 'dart:convert';

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