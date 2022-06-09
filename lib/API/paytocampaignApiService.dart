import 'dart:developer';

import 'package:http/http.dart' as http;
import '../userprovider.dart';
import 'ApiConstants.dart';
import 'paytocampaignConstant.dart';


class paytocampaignApi {
  Future<bool?> paytocampaign(Userstate userstate,String campaignId,String price) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.PayToCampaign,);
      url =url.replace(queryParameters: <String,String>{'campaignId': campaignId, 'price': price,});
      var response = await http.get(
          url,
        headers: {
          'Authorization':
          'Bearer ${userstate.user!.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}