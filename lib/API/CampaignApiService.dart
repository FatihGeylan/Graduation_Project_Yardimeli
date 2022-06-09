import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'ApiConstants.dart';
import '../Model/ModelCampaign.dart';

class campaignApiService {
  Future<Campaignmodel?> getallCampaigns() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.GetActiveCampaigns);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var e=campaignFromJson(response.body) ;
        return e;
      }
    } catch (e) {
      log(e.toString());
    }
  }
  // Future<String?> getuserbyid(String id) async {
  //   try {
  //     var url = Uri.parse(CampaignConstant.baseUrl + CampaignConstant.getuserbyid,);
  //     url =url.replace(queryParameters: <String,String>{'id': id});
  //     var response=await http.get(url);
  //     var decoded=json.decode(response.body);
  //     if (decoded['resultStatus']  == 0) {
  //       return decoded["data"] ;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

}
final campaignApiServiceProvider=Provider((ref){
  return campaignApiService();

});