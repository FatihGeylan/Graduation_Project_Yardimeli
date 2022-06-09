import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:yardimeliflutter/animation/horizontalScrollAnimation.dart';
import 'package:yardimeliflutter/campaignpagestate.dart';
import 'package:yardimeliflutter/pages/campaignpayPage.dart';
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
      body: campaignprovider.Allcampaign == null ||
              campaignprovider.Allcampaign.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            onRefresh: () async{
              refresh(campaignprovider);
            },
            child: SingleChildScrollView(
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
                      height: 290,
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
    List<String> cities = ['İstanbul','Ankara','İzmir','Eskişehir','Bursa'];
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
                          "Kategoriye göre",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Container(
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
                        padding: EdgeInsets.only(left: 20, top: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Şehire göre",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                             scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            child: ExpansionTile(
                                title: Text("tüm şehirler"),
                              children: cities.map((e) {
                                return Container(
                                  padding: EdgeInsets.only(left: 20, top: 16),
                                  alignment: Alignment.centerLeft,
                                    child: Text(e),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      //Spacer(),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                        height: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {

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
                                  campaignprovider.filterbycategory();
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
                                if (campaignprovider.selectedSortvalue == 1) {
                                  campaignprovider.sortnewest();
                                  Navigator.of(context).pop();
                                } else if (campaignprovider.selectedSortvalue ==
                                    2) {
                                  campaignprovider.sortoldest();
                                  Navigator.of(context).pop();
                                } else if (campaignprovider.selectedSortvalue ==
                                    3) {
                                  campaignprovider.sortclosest();
                                  Navigator.of(context).pop();
                                } else if (campaignprovider.selectedSortvalue ==
                                    4) {
                                  campaignprovider.sortfurthest();
                                  Navigator.of(context).pop();
                                }
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
        height: 255,
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
                  height: 100,
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
                      pageBuilder: (c, a1, a2) => campaignpayPage(campaign),
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
