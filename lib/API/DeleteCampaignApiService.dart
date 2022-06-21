import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'ApiConstants.dart';
import '../authprovider.dart';

class DeleteCampaignApi {
  Future<bool> deletecampaign (String campaignId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.RemoveCampaign,);
      url =url.replace(queryParameters: <String,String>{'campaignId': campaignId,});
      var response = await http.get(url);
      var decoded=json.decode(response.body);
      if (decoded['resultStatus']  == 0) {
        return true ;
      }
      else{
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}