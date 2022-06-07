import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yardimeliflutter/API/ConstantAddCampaign.dart';
import 'package:yardimeliflutter/userprovider.dart';

class addCampaignApiService {

  Future<http.Response?> AddCampaign(Userstate userstate, String name, String description, String categoryId, int limit, String photoUrl, String city ) async {
    try {
      var body = jsonEncode({
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
        'Authorization':
        'Bearer ${userstate.user!.accessToken}',
      }, body: body);

        return response;

    }catch (e) {
      log(e.toString());
    }
  }
}