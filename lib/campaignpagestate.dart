import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/UserProvider.dart';
import 'package:yardimeliflutter/authprovider.dart';

import 'API/CampaignApiService.dart';
import 'Model/ModelCampaign.dart';
import 'Model/ModelUser.dart';

class campaignpageRepository extends ChangeNotifier{
  Campaignmodel orgmodel = new Campaignmodel();
  List<Campaign> Allcampaign =[];
  List<Campaign> campaignsamecity=[];
  List<Campaign> completedcampaign=[];
  List<Campaign> filteredcampaign=[];
  List<Campaign> sortedcampaign=[];
  int selectedSortvalue=1;
  int lastselectedSortvalue=1;
  List<bool> filtercategorybutton=[false,false,false];
  List<bool> selectcategorybutton=[false,false,false];
  bool isloading =true;
  String selectedcityname="";
  int lastselectedcity =0;
  List<bool> selectedcity = List.generate(81, (i) => false);
  UserRepository userrepo=new UserRepository();
  Authstate authstate=new Authstate();

  // final campaignApiService campaignapi;
  // campaignpageRepository(this.campaignapi);

  Future<void> getData() async {
    orgmodel = (await campaignApiService().getallCampaigns())!;
    await userrepo.getUser(authstate);
    campaignsamecity = orgmodel.data!.where((element) => element.city == userrepo.user!.City).toList();
    Allcampaign=orgmodel.data!;
    Sort();
    isloading=false;
    notifyListeners();
  }
  void clearfilter(){
    filtercategorybutton=[false,false,false];
    selectedcityname="";
    selectedcity=List.filled(81, false);
    lastselectedcity =0;
    notifyListeners();
  }
  void Sort(){
    if (selectedSortvalue == 1) {
      sortnewest();
    } else if (selectedSortvalue ==
        2) {
      sortoldest();
    } else if (selectedSortvalue ==
        3) {
      sortclosest();
    } else if (selectedSortvalue ==
        4) {
      sortfurthest();
    }
  }
  void changeselectedsortvalue(int value){
    selectedSortvalue=value;
    notifyListeners();
  }
  void sortnewest(){
    Allcampaign.sort((a,b){
      return b.createdDate.compareTo(a.createdDate);
    });
    notifyListeners();
  }
  void sortoldest(){
    Allcampaign.sort((a,b){
      return a.createdDate.compareTo(b.createdDate);
    });
    notifyListeners();
  }
  void sortclosest(){
    sortedcampaign=notcompleted();
    Allcampaign.clear();
    sortedcampaign.sort((a, b) {
      return (b.currentMoney/b.limit).compareTo(a.currentMoney/a.limit);
    },);
    Allcampaign=sortedcampaign;
    notifyListeners();
  }
  void sortfurthest(){
    sortedcampaign=notcompleted();
    Allcampaign.clear();
    sortedcampaign.sort((a, b) {
      return  (a.currentMoney/a.limit).compareTo(b.currentMoney/b.limit);
    },);
    Allcampaign=sortedcampaign;
    notifyListeners();
  }
  void clearlist(){
    Allcampaign.clear();
    campaignsamecity.clear();
    //notifyListeners();
  }
  void changefiltercategory(int index){
    filtercategorybutton[index] = !filtercategorybutton[index];
    notifyListeners();
  }
  void CategorySelect(int index){
    if(selectcategorybutton[index] == true) {
      selectcategorybutton[index] = !selectcategorybutton[index];
    }
    else{
      ClearCategorySelect();
      selectcategorybutton[index] = true;
    }
    notifyListeners();
  }
  void ClearCategorySelect(){
    for(int i=0;i<selectcategorybutton.length;i++){
      selectcategorybutton[i] = false;
    }
    notifyListeners();
  }
  void filterbycategory(){
    filteredcampaign=Allcampaign.where((element) {
      if(element.categoryId=="1"&&filtercategorybutton[0]){
        return true;
      }
      else if(element.categoryId=="2"&&filtercategorybutton[1]){
        return true;
      }
      else if(element.categoryId=="3"&&filtercategorybutton[2]){
        return true;
      }
      else{
        return false;
      }
    }).toList();
    Allcampaign.clear();
    Allcampaign=[...filteredcampaign];
    filteredcampaign.clear();
    Sort();
  }
  void filterbycity(){
    filteredcampaign=Allcampaign.where((element) {
      if(element.city==selectedcityname){
        return true;
      }
      else{
        return false;
      }
    }).toList();
    Allcampaign.clear();
    Allcampaign=[...filteredcampaign];
    filteredcampaign.clear();
    Sort();
  }
  List<Campaign> completed(){
    return Allcampaign.where((element) => element.limit-element.currentMoney<0).toList();
  }
  List<Campaign> notcompleted(){
    return Allcampaign.where((element) => element.limit-element.currentMoney>0).toList();
  }
}

final campaignpageProvider =ChangeNotifierProvider((ref){
  return campaignpageRepository();
});
