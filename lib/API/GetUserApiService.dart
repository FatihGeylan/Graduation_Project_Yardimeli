import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:yardimeliflutter/Model/ModelUser.dart';
import 'package:yardimeliflutter/authprovider.dart';

import 'ApiConstants.dart';

class userApiService {
  Future<Usermodel?> getUser(Authstate authstate) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.GetUserByUserName);
      var response = await http.get(url,
        headers: {
        // HttpHeaders.authorizationHeader:
        // authstate.auth!.accessToken,
        //   HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':
          'Bearer ${authstate.auth!.accessToken}',
        },);
      if (response.statusCode == 200) {
        var e=userFromJson(response.body) ;
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
final getUserApiServiceProvider=Provider((ref){
  return userApiService();

});