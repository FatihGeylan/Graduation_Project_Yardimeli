import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yardimeliflutter/API/ApiConstants.dart';

class AuthAPI {

  Future<http.Response> login(String email, String password) async {

    var body = jsonEncode({'email': email, 'password': password});
    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.CreateToken);

    http.Response response =
    await http.post(url,headers: {'Content-Type': 'application/json; charset=UTF-8'} , body: body);

    return response;
  }

}