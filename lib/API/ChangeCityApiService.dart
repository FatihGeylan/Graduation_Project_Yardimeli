import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'ApiConstants.dart';
import '../authprovider.dart';

class changeCityApi {
  Future<bool> changecity(Authstate authstate,String newCity) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.ChangeCity,);
      url =url.replace(queryParameters: <String,String>{'newCity': newCity,});
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