import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:yardimeliflutter/Model/ModelOganization.dart';
import 'package:yardimeliflutter/animation/horizontalScrollAnimation.dart';
import 'package:yardimeliflutter/pages/payPage.dart';

import '../Model/ModelCampaign.dart';
import '../my_flutter_app_icons.dart';

class CampaignDetailPage extends StatelessWidget {
  final Campaign campaign;
  final String axis;
  const CampaignDetailPage(this.campaign, this.axis, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: "yardimelibaslik",
            child: Material(
              color: Color(0xff7f0000),
              child: Text(
                "yardım eli ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
            )
        ),
        backgroundColor: Color(0xff7f0000),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Hero(
                              tag: "orgpic" + campaign.id+axis,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: Image.file(File(campaign.photoUrl)).image,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if(campaign.categoryId=="1")...[
                            campaigncategorylabel(
                              text: Text(" Sağlık"),
                              icon: Icon(Icons.favorite_border),
                              color: Colors.redAccent.shade100,
                            )
                          ]else if(campaign.categoryId=="2")...[
                            campaigncategorylabel(
                              text: Text(" Eğitim"),
                              icon: Icon(Icons.school_outlined),
                              color: Colors.lightBlueAccent.shade100,
                            )
                          ]else if(campaign.categoryId=="3")...[
                            campaigncategorylabel(
                              text: Text(" Sokak Hayvanları"),
                              icon: Icon(Icons.pets_outlined),
                              color: Colors.greenAccent.shade100,
                            )
                          ],
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: horizontalSrollAnimation(
                                  animationtext: Text(
                                    campaign.name,
                                    style: const TextStyle(
                                      fontSize: 30,
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8,left: 8,right: 8),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${campaign.userName} tarafından  ●${campaign.city}",
                                style: TextStyle(
                                    color: Color(0xff5e5e5e),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          LinearPercentIndicator(
                            percent: campaign.currentMoney>campaign.limit? 1:campaign.currentMoney/campaign.limit,
                            progressColor: Color(0xff7f0000),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(width: 2, color: Color(0xffe6e5ea)))),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              child: Text(
                                "${campaign.limit} ₺ hedefin ${campaign.currentMoney} ₺'si toplandı.",
                                style: TextStyle(color: Color(0xff5e5e5e)),
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            alignment: Alignment.topLeft,
                            child: Text(campaign.description,
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(width: 2, color: Color(0xffe6e5ea)))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) =>
                                        payPage.campaign(
                                            campaign),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                            opacity: anim, child: child),
                                    transitionDuration:
                                    Duration(milliseconds: 300),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class campaigncategorylabel extends StatelessWidget {
  Icon icon;
  Text text;
  Color color;
  Color? bordercolor;
  campaigncategorylabel({
    required this.color,
    required this.text,
    required this.icon,
    this.bordercolor,
    Key? key,
  }) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8,bottom: 8),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: bordercolor != null ? bordercolor!:color
              ),
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(20),
              ),
            ),
            child: Row(
              //mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                text
              ],
            ),

          ),
        ],
      ),
    );
  }
}
