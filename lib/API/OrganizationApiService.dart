import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'ConstantsOrganizations.dart';
import '../Model/ModelOganization.dart';

class ApiService {
  Future<Organizationmodel?> getUsers() async {
    try {
      var url = Uri.parse(OrganizationConstant.baseUrl + OrganizationConstant.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //Organizationmodel.fromJson(jsonDecode(response.body));
        //List<Organizationmodel> _model =
        return organizationFromJson(response.body) ;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}