import 'dart:developer';
import 'package:http/http.dart' as http;
import 'ApiConstants.dart';
import '../Model/ModelOganization.dart';
import 'ApiConstants.dart';

class ApiService {
  Future<Organizationmodel?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.GetOrganizations);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return organizationFromJson(response.body) ;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}