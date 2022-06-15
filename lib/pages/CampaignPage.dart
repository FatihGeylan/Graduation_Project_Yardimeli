import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:yardimeliflutter/animation/horizontalScrollAnimation.dart';
import 'package:yardimeliflutter/campaignpagestate.dart';
import 'package:yardimeliflutter/pages/payPage.dart';
import '../Model/ModelCampaign.dart';
import 'CampaignDetailPage.dart';

class CampaignPage extends ConsumerStatefulWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends ConsumerState<CampaignPage> {
  @override
  void initState() {
    ref.read(campaignpageProvider).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final campaignprovider = ref.watch(campaignpageProvider);
    return Scaffold(
      body: campaignprovider.isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            onRefresh: () async{
              refresh(campaignprovider);
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    filterBottomSheet(context, campaignprovider);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.filter_alt_outlined),
                                      Text(" Filtrele")
                                    ],
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    _SortBottomSheet(context, campaignprovider);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Icon(Icons.sort), Text(" Sırala")],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Şehrindeki kampanyalar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 270,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: campaignprovider.campaignsamecity.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) =>
                                        CampaignDetailPage(
                                            campaignprovider
                                                .campaignsamecity[index],
                                            "vert"),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                            opacity: anim, child: child),
                                    transitionDuration:
                                        Duration(milliseconds: 300),
                                  ),
                                );
                              },
                              child: CampaignCard(
                                  campaignprovider.campaignsamecity[index],
                                  "vert"));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tüm kampanyalar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: campaignprovider.Allcampaign.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) =>
                                          CampaignDetailPage(
                                              campaignprovider.Allcampaign[index],
                                              "hori"),
                                      transitionsBuilder: (c, anim, a2, child) =>
                                          FadeTransition(
                                              opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 300),
                                    ),
                                  );
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) {return OrganizationDetailPage(orgmodel.data![index]);},));
                                },
                                child: CampaignCard(
                                    campaignprovider.Allcampaign[index], "hori"
                                )
                            );
                          },
                        ),
                          // loading: () {
                          //   return Center(child: CircularProgressIndicator());
                          // },
                          // error: ( error,stackTrace) {
                          //   return Text("error");
                          // },
                          // onRefresh: ()async {  ref.refresh(campaignlistProvider);},
                    ),
                  ],
                ),
              ),
          ),
    );
  }

  Future refresh(campaignpageRepository campaignprovider)async{
    campaignprovider.clearlist();
    campaignprovider.getData();
  }
  Future<dynamic> filterBottomSheet(BuildContext context,campaignpageRepository campaignprovider) {
    List<String> cities = ['Adana','Adıyaman','Afyon','Ağrı','Amasya','Ankara','Antalya','Artvin','Aydın','Balıkesir',
      'Bilecik','Bingöl','Bitlis','Bolu','Burdur', 'Bursa','Çanakkale','Çankırı','Çorum','Denizli',
      'Diyarbakır','Edirne','Elazığ','Erzincan','Erzurum','Eskişehir','Gaziantep','Giresun','Gümüşhane','Hakkari',
      'Hatay','Isparta','Mersin','İstanbul','İzmir','Kars','Kastamonu','Kayseri','Kırklareli','Kırşehir',
      'Kocaeli','Konya','Kütahya','Malatya','Manisa','Kahramanmaraş','Mardin','Muğla','Muş','Nevşehir',
      'Niğde','Ordu','Rize','Sakarya','Samsun','Siirt','Sinop','Sivas','Tekirdağ','Tokat',
      'Trabzon','Tunceli','Şanlıurfa','Uşak','Van','Yozgat','Zonguldak','Aksaray','Bayburt','Karaman',
      'Kırıkkale','Batman','Şırnak','Bartın','Ardahan','Iğdır','Yalova','Karabük','Kilis','Osmaniye',
      'Düzce',
    ];
    final itemController=ItemScrollController();
    Future.delayed(Duration(milliseconds: 500)).then((value) => itemController.scrollTo(
      index: campaignprovider.lastselectedcity, duration: Duration(milliseconds: 500),));

    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * .60,
                  padding: EdgeInsets.only(top: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 3,
                        height: 0,
                        indent: 175,
                        endIndent: 175,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 20, top: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kategoriye göre",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 10, top: 8),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState((){
                                  campaignprovider.changefiltercategory(0);
                                });
                              },
                              child: campaigncategorylabel(
                                text: Text(" Sağlık"),
                                icon: Icon(Icons.favorite_border),
                                color:campaignprovider.filtercategorybutton[0]? Colors.redAccent.shade100:Colors.white,
                                bordercolor: campaignprovider.filtercategorybutton[0]? null:Colors.redAccent.shade100,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState((){
                                  campaignprovider.changefiltercategory(1);
                                });
                              },
                              child: campaigncategorylabel(
                                text: Text(" Eğitim"),
                                icon: Icon(Icons.school_outlined),
                                color: campaignprovider.filtercategorybutton[1]?Colors.lightBlueAccent.shade100:Colors.white,
                                bordercolor: campaignprovider.filtercategorybutton[1]?null:Colors.lightBlueAccent.shade100,
                              ),
                            ),
                            GestureDetector(
                              onTap:() {
                                setState((){
                                  campaignprovider.changefiltercategory(2);
                                });
                              },
                              child: campaigncategorylabel(
                                text: Text(" Sokak Hayvanları"),
                                icon: Icon(Icons.pets_outlined),
                                color:campaignprovider.filtercategorybutton[2]? Colors.greenAccent.shade100:Colors.white,
                                bordercolor: campaignprovider.filtercategorybutton[2]?null:Colors.greenAccent.shade100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                        height: 0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 20, top: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Şehire göre",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      //Color(0xff7f0000)
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 4,bottom: 4,right: 10),
                          alignment: Alignment.topCenter,
                          child: ScrollablePositionedList.builder(
                            itemScrollController: itemController,
                            itemCount: cities.length,
                              itemBuilder: (_,i){
                                return Container(
                                  color:campaignprovider.selectedcity[i]?Color(0xff7f0000):null,
                                  child: ListTile(
                                    dense: true,
                                    minLeadingWidth: 10,
                                    //tileColor: _selected[i]?Color(0xff7f0000):null,
                                    leading: Text("${i+1}",
                                    style: TextStyle(
                                      color: campaignprovider.selectedcity[i]?Colors.white:null,
                                    ),
                                    ),
                                    onTap: () {
                                      setState((){
                                        if(i!=campaignprovider.lastselectedcity){
                                          campaignprovider.selectedcity[campaignprovider.lastselectedcity]=false;
                                          campaignprovider.selectedcity[i]=!campaignprovider.selectedcity[i];
                                          campaignprovider.lastselectedcity=i;
                                          campaignprovider.selectedcityname=cities[i];
                                        }
                                        else{
                                          campaignprovider.selectedcity[i]=!campaignprovider.selectedcity[i];
                                          campaignprovider.selectedcityname="";
                                          campaignprovider.lastselectedcity=0;
                                        }
                                      });
                                    },
                                    title: Text(
                                        cities[i],
                                      style: TextStyle(
                                        color: campaignprovider.selectedcity[i]?Colors.white:null,
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                      //Spacer(),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                        height: 0,
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState((){
                                    campaignprovider.clearfilter();
                                    campaignprovider.getData();
                                  });
                                },
                                child: Text("Filtreleri temizle"),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async{
                                  await campaignprovider.getData();
                                  if(campaignprovider.filtercategorybutton.contains(true)){
                                    campaignprovider.filterbycategory();
                                  }
                                  if(campaignprovider.selectedcityname!=""){
                                    campaignprovider.filterbycity();
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text("Uygula"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        });
  }

  void _SortBottomSheet(context, campaignpageRepository campaignprovider) {
    campaignprovider.lastselectedSortvalue = campaignprovider.selectedSortvalue;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Container(
                  padding: EdgeInsets.only(top: 12),
                  height: MediaQuery.of(context).size.height * .60,
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 3,
                        height: 0,
                        indent: 175,
                        endIndent: 175,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sıralama",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      sortRadioListTile(campaignprovider, setState,
                          Text("En yeni kampanyalar (varsayılan)"), 1),
                      sortdivider(),
                      sortRadioListTile(campaignprovider, setState,
                          Text("En eski kampanyalar"), 2),
                      sortdivider(),
                      sortRadioListTile(campaignprovider, setState,
                          Text("Hedefine en yakın kampanyalar"), 3),
                      sortdivider(),
                      sortRadioListTile(campaignprovider, setState,
                          Text("Hedefine en uzak kampanyalar"), 4),
                      Spacer(),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                        height: 0,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: ElevatedButton(
                              onPressed: () {
                                campaignprovider.Sort();
                                Navigator.of(context).pop();
                              },
                              child: campaignprovider.selectedSortvalue ==
                                      campaignprovider.lastselectedSortvalue
                                  ? Text("Vazgeç")
                                  : Text("Uygula")),
                        ),
                      )
                    ],
                  ));
            },
          );
        });
  }

  Divider sortdivider() {
    return Divider(
      color: Colors.grey.shade200,
      thickness: 2,
      height: 0,
      indent: 20,
      endIndent: 20,
    );
  }

  RadioListTile<int> sortRadioListTile(campaignpageRepository campaignprovider,
      StateSetter setState, Text text, int value) {
    return RadioListTile<int>(
      activeColor: Color(0xff7f0000),
      value: value,
      groupValue: campaignprovider.selectedSortvalue,
      title: text,
      onChanged: (value) {
        setState(() {
          campaignprovider.selectedSortvalue = value!;
        });
      },
    );
  }
}

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final String axis;
  const CampaignCard(
    this.campaign,
    this.axis, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: UniqueKey(),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(16),
      child: Container(
        height: 240,
        width: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 2, color: Color(0xffe6e5ea)),
              )),
              child: Hero(
                tag: "orgpic" + campaign.name + axis,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("lib/pictures/${campaign.photoUrl}"),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: horizontalSrollAnimation(
                  animationtext: Text(
                campaign.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${campaign.userName} tarafından  ●${campaign.city}",
                  style: TextStyle(
                      color: Color(0xff5e5e5e), fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            LinearPercentIndicator(
              //percent: 0.7,
              percent: campaign.currentMoney>campaign.limit? 1:campaign.currentMoney/campaign.limit,
              progressColor: Color(0xff7f0000),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                "${campaign.limit} ₺ hedefin ${campaign.currentMoney} ₺'si toplandı.",
                style: TextStyle(color: Color(0xff5e5e5e)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 2, color: Color(0xffe6e5ea)))),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => payPage.campaign(campaign),
                      transitionsBuilder: (c, anim, a2, child) =>
                          FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 300),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.handshake_outlined),
                    Text("   Bağışta bulun")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
