import 'dart:developer';

import 'package:http/http.dart' as http;

import 'ConstantCampaign.dart';
import 'ModelCampaign.dart';

class ApiService {
  Future<Campaignmodel?> getUsers() async {
    try {
      var url = Uri.parse(CampaignConstant.baseUrl + CampaignConstant.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //Organizationmodel.fromJson(jsonDecode(response.body));
        //List<Organizationmodel> _model =
        return campaignFromJson(response.body) ;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}