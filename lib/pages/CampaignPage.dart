import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:yardimeliflutter/animation/horizontalScrollAnimation.dart';

import '../API/CampaignApiService.dart';
import '../Model/ModelCampaign.dart';
import 'CampaignDetailPage.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  Campaignmodel orgmodel = new Campaignmodel();
  List<Campaign> Allcampaign =[];
  late final List<Campaign> campaignsamecity;
  int selectedSortvalue=1;
  int lastselectedSortvalue=1;
  void _getData() async {
    orgmodel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    campaignsamecity =
        orgmodel.data!.where((element) => element.city == "Istanbul").toList();
    Allcampaign=orgmodel.data!;
    Allcampaign.sort((a,b){
      return a.createdDate.compareTo(b.createdDate);
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Allcampaign == null || Allcampaign.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.filter_alt_outlined),
                                    Text(" Filtrele")
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  _SortBottomSheet(context);
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
                      itemCount: campaignsamecity.length,
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
                                          campaignsamecity[index], "vert"),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      Duration(milliseconds: 300),
                                ),
                              );
                            },
                            child: CampaignCard(campaignsamecity[index], "vert"));
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
                      itemCount: Allcampaign.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) =>
                                      CampaignDetailPage(
                                          Allcampaign[index], "hori"),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      Duration(milliseconds: 300),
                                ),
                              );
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) {return OrganizationDetailPage(orgmodel.data![index]);},));
                            },
                            child: CampaignCard(Allcampaign[index], "hori"));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _SortBottomSheet(context) {
    lastselectedSortvalue =selectedSortvalue;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context,setState){
              return Container(
                  padding: EdgeInsets.only(top: 16),
                  height: MediaQuery.of(context).size.height * .60,
                  child: Column(

                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20,top: 8),
                        alignment: Alignment.centerLeft,
                        child: Text("Sıralama",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),

                      RadioListTile<int>(
                        activeColor: Color(0xff7f0000),
                        value: 1,
                        groupValue: selectedSortvalue,
                        title: Text("En yeni kampanyalar (varsayılan)"),
                        onChanged: (value){
                          setState(() {
                            selectedSortvalue = value!;
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                        height: 0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      RadioListTile<int>(
                        activeColor: Color(0xff7f0000),
                        value: 2,
                        groupValue: selectedSortvalue,
                        title: Text("En eski kampanyalar"),
                        onChanged: (value){
                          setState(() {
                            selectedSortvalue = value!;
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                        height: 0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      RadioListTile<int>(
                        activeColor: Color(0xff7f0000),
                        value: 3,
                        groupValue: selectedSortvalue,
                        title: Text("Hedefine en yakın kampanyalar"),
                        onChanged: (value){
                          setState(() {
                            selectedSortvalue = value!;
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                        height: 0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      RadioListTile<int>(
                        activeColor: Color(0xff7f0000),
                        value: 4,
                        groupValue: selectedSortvalue,
                        title: Text("Hedefine en uzak kampanyalar"),
                        onChanged: (value){
                          setState(() {
                            selectedSortvalue = value!;
                          });
                        },
                      ),
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
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                          child: ElevatedButton(
                              onPressed: () {
                                if(selectedSortvalue==1){
                                  Allcampaign.sort((a,b){
                                    return a.createdDate.compareTo(b.createdDate);
                                  });
                                  setState((){
                                    Allcampaign=List.from(Allcampaign);
                                  });
                                  Navigator.of(context).pop();
                                }
                                else if(selectedSortvalue==2){
                                  Allcampaign.sort((a,b){
                                    return b.createdDate.compareTo(a.createdDate);
                                  });
                                  setState((){
                                    Allcampaign=List.from(Allcampaign);
                                  });
                                  Navigator.of(context).pop();
                                }


                              },
                              child: selectedSortvalue==lastselectedSortvalue?Text("Vazgeç"):Text("Uygula")
                          ),
                        ),
                      )
                    ],
                  ));
            },
          );
        });
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
                  "Mert Çelik tarafından  ●${campaign.city}",
                  style: TextStyle(
                      color: Color(0xff5e5e5e), fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            LinearPercentIndicator(
              percent: 0.7,
              //percent: orgmodel.data![index].currentMoney>orgmodel.data![index].limit? 1:orgmodel.data![index].currentMoney/orgmodel.data![index].limit,
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
                onPressed: () {},
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
