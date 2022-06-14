import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yardimeliflutter/API/ApiConstants.dart';
import 'package:yardimeliflutter/authprovider.dart';

class CreateUserApiService {

  Future<http.Response?> CreateUser(String city, String firstName, String lastName, String userName, String email, String password ) async {

    var body = jsonEncode({
      'city': city,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
    });
    var url = Uri.parse(ApiConstants.baseUrl+ ApiConstants.CreateUser);

    http.Response response =
    await http.post(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: body);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //throw Exception('Failed to create album.');
      print(response.statusCode);
    }

  }
}