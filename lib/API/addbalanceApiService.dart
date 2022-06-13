import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../authprovider.dart';
import 'ApiConstants.dart';


class addbalanceApi {
  Future<bool> addbalance(Authstate authstate,String price) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.addBalance,);
      url =url.replace(queryParameters: <String,String>{'price': price});
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