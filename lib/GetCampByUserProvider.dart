import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/UserProvider.dart';
import 'package:yardimeliflutter/authprovider.dart';

import 'API/CampaignApiService.dart';
import 'API/GetCampaignsByUserApiService.dart';
import 'Model/ModelCampaign.dart';
import 'Model/ModelUser.dart';

class CampaignByUserRepository extends ChangeNotifier {
  Campaignmodel orgmodel = new Campaignmodel();
  List<Campaign> AllCampaignByUser = [];
  UserRepository userrepo = new UserRepository();
  Authstate authstate = new Authstate();
  bool isloading = true;

  // final campaignApiService campaignapi;
  // campaignpageRepository(this.campaignapi);

  Future<void> getData(Authstate authstate) async {
    orgmodel = (await GetCampaignsByUserApiService().getCampaignByUser(authstate))!;
    await userrepo.getUser(authstate);
    AllCampaignByUser = orgmodel.data!;
    isloading = false;
    notifyListeners();
  }
  void clearlist(){
    AllCampaignByUser.clear();
    //notifyListeners();
  }
}

final campaignByUserProvider =ChangeNotifierProvider((ref){
  return CampaignByUserRepository();
});