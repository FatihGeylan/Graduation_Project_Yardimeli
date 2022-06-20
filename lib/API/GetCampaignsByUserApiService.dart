import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:yardimeliflutter/Model/ModelCampaign.dart';
import 'package:yardimeliflutter/Model/ModelUser.dart';
import 'package:yardimeliflutter/authprovider.dart';

import 'ApiConstants.dart';

class GetCampaignsByUserApiService {
  Future<Campaignmodel?> getCampaignByUser(Authstate authstate) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.GetCampaignsByToken);
      var response = await http.get(url,
        headers: {
          'Authorization':
          'Bearer ${authstate.auth!.accessToken}',
        },);
      if (response.statusCode == 200) {
        var e=campaignFromJson(response.body) ;
        return e;
      }
    } catch (e) {
      log(e.toString());
    }
  }

}