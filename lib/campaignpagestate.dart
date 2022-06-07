import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'API/CampaignApiService.dart';
import 'Model/ModelCampaign.dart';

class campaignpageRepository extends ChangeNotifier{
  Campaignmodel orgmodel = new Campaignmodel();
  List<Campaign> Allcampaign =[];
  List<Campaign> campaignsamecity=[];
  List<Campaign> completedcampaign=[];
  int selectedSortvalue=1;
  int lastselectedSortvalue=1;
  List<bool> filtercategorybutton=[false,false,false];
  List<bool> selectcategorybutton=[false,false,false];
  // final campaignApiService campaignapi;
  // campaignpageRepository(this.campaignapi);

  Future<void> getData() async {
    orgmodel = (await campaignApiService().getUsers())!;
    //Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    campaignsamecity =
        orgmodel.data!.where((element) => element.city == "Istanbul").toList();
    Allcampaign=orgmodel.data!;
    Allcampaign.sort((a,b){
      return a.createdDate.compareTo(b.createdDate);
    });
    notifyListeners();
  }
  void changeselectedsortvalue(int value){
    selectedSortvalue=value;
    notifyListeners();
  }
  void sortnewest(){
    Allcampaign.sort((a,b){
      return a.createdDate.compareTo(b.createdDate);
    });
    notifyListeners();
  }
  void sortoldest(){
    Allcampaign.sort((a,b){
      return b.createdDate.compareTo(a.createdDate);
    });
    notifyListeners();
  }
  void sortclosest(){
    notcompleted().sort((a, b) {
      return (a.limit-a.currentMoney).compareTo(b.limit-b.currentMoney);
    },);
    notifyListeners();
  }
  void sortfurthest(){
    notcompleted().sort((a, b) {
      return (b.limit-b.currentMoney).compareTo(a.limit-a.currentMoney);
    },);
    notifyListeners();
  }
  void clearlist(){
    Allcampaign.clear();
    campaignsamecity.clear();
    notifyListeners();
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
  List<Campaign> completed(){
    return orgmodel.data!.where((element) => element.limit-element.currentMoney<0).toList();
  }
  List<Campaign> notcompleted(){
    return orgmodel.data!.where((element) => element.limit-element.currentMoney>0).toList();
  }
}

final campaignpageProvider =ChangeNotifierProvider((ref){
  return campaignpageRepository();
});

// final campaignlistProvider =FutureProvider((ref){
//   return ref.watch(campaignpageProvider).getData();
// });