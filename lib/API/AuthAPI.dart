import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'ConstantsAuth.dart';

class AuthAPI {
  // Future<http.Response> signUp(String email, String password,) async {
  //   var body = jsonEncode({
  //     'customer': {
  //       'email': email,
  //       'password': password,
  //     }
  //   });
  //
  //   http.Response response =
  //   await http.post(super.customersPath, headers: super.headers, body: body);
  //   return response;
  // }

  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});
    var url = Uri.parse(UserConstant.api);



    http.Response response =
    await http.post(url,headers: UserConstant().headers , body: body);

    return response;
  }


  // Future<http.Response> logout(int id, String token) async {
  //   var body = jsonEncode({'id': id, 'token': token});
  //
  //   http.Response response = await http.post(super.logoutPath,
  //       headers: super.headers, body: body);
  //
  //   return response;
  // }

}