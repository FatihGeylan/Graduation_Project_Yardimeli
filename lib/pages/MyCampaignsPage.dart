import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:yardimeliflutter/pages/AddCampaignPage.dart';

import '../GetCampByUserProvider.dart';
import '../Model/ModelCampaign.dart';
import '../UserProvider.dart';
import '../animation/horizontalScrollAnimation.dart';
import '../authprovider.dart';
import 'CampaignDetailPage.dart';

class MyCampaignsPage extends ConsumerStatefulWidget {
  const MyCampaignsPage({Key? key}) : super(key: key);

  @override
  _MyCampaignsPageState createState() => _MyCampaignsPageState();
}

class _MyCampaignsPageState extends ConsumerState<MyCampaignsPage> {
  Authstate authstate = new Authstate();

  @override
  void initState() {
    // final authprovider = ref.watch(authProvider);
    ref.read(campaignByUserProvider).getData(authstate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final campProvider = ref.watch(campaignByUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
          child: Text(
            'Yardım Eli',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: campProvider.isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                refresh(campProvider);
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7f0000),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: MediaQuery.of(context).size.height/9*2,
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Hemen bir yardım eli bulmak için kampanya başlatabilirsiniz.',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white, elevation: 20),
                              onPressed: () {
                                _addCampaignPage(context);
                              },
                              child: Text(
                                'Kampanya Ekle',
                                style: TextStyle(color: Color(0xff7f0000)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: campProvider.AllCampaignByUser.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) =>
                                      CampaignDetailPage(
                                          campProvider.AllCampaignByUser[index],
                                          "hori",true),
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
                                campProvider.AllCampaignByUser[index], "hori"
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
    );
  }

  Future refresh(CampaignByUserRepository campaignprovider) async {
    campaignprovider.clearlist();
    campaignprovider.getData(authstate);
  }

  void _addCampaignPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const AddCampaignPage();
      },
    ));
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
                tag: "orgpic" + campaign.id + axis,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.file(File(campaign.photoUrl)).image,
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
          ],
        ),
      ),
    );
  }
}
