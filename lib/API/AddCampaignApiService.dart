import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yardimeliflutter/API/ConstantAddCampaign.dart';
import 'package:yardimeliflutter/authprovider.dart';

class addCampaignApiService {

  Future<http.Response?> AddCampaign(Authstate authstate,String userId, String name, String description, String categoryId, int limit, String photoUrl, String city ) async {

      var body = jsonEncode({
        'userId': userId,
        'name': name,
        'description': description,
        'categoryId': categoryId,
        'limit': limit,
        'photoUrl': photoUrl,
        'city': city,
      });
      var url = Uri.parse(AddCampaignConstant.api);

      http.Response response =
      await http.post(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
        'Bearer ${authstate.auth!.accessToken}',
      }, body: body);

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        return response;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        //throw Exception('Failed to create album.');
        print(response.statusCode);
      }

  }
}