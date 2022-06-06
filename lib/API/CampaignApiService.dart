import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'ConstantCampaign.dart';
import '../Model/ModelCampaign.dart';

class campaignApiService {
  Future<Campaignmodel?> getUsers() async {
    try {
      var url = Uri.parse(CampaignConstant.baseUrl + CampaignConstant.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return campaignFromJson(response.body) ;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
final campaignApiServiceProvider=Provider((ref){
  return campaignApiService();

});