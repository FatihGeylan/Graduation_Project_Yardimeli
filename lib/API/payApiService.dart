import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'ApiConstants.dart';
import '../authprovider.dart';

class payApi {
  Future<bool> paytocampaign(Authstate authstate,String campaignId,String price) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.PayToCampaign,);
      url =url.replace(queryParameters: <String,String>{'campaignId': campaignId, 'price': price,});
      var response = await http.get(
          url,
        headers: {
          'Authorization':
          'Bearer ${authstate.auth!.accessToken}',
        },
      );
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
  Future<bool> paytoorganization(Authstate authstate,String organizationId,String price) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.DonateToOrganization,);
      url =url.replace(queryParameters: <String,String>{'organizationId': organizationId, 'price': price,});
      var response = await http.get(
        url,
        headers: {
          'Authorization':
          'Bearer ${authstate.auth!.accessToken}',
        },
      );
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