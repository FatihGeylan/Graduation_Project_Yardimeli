import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/Model/ModelCampaign.dart';

import '../API/paytocampaignApiService.dart';
import '../animation/horizontalScrollAnimation.dart';
import '../userprovider.dart';

class campaignpayPage extends ConsumerStatefulWidget {
  final Campaign campaign;
  const campaignpayPage(this.campaign,{Key? key}) : super(key: key);

  @override
  _campaignpayPageState createState() => _campaignpayPageState();
}

class _campaignpayPageState extends ConsumerState<campaignpayPage> {
  paytocampaignApi payApi=paytocampaignApi();

  final paycontoller=TextEditingController();

  @override
  void dispose() {
    paycontoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userprovider = ref.watch(userProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        children: [
          Material(
            elevation: 8,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerRight,
                              child: Icon(
                                  Icons.account_balance_wallet_outlined,
                                size: 70,
                              ))
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Bakiye",
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                              Text(
                                "0.0 TL",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff7f0000),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    height: 0,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: Color(0xff7f0000),
                                  width: 2)
                              )
                          ),
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xff7f0000)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                        onPressed: () {
                    },
                        child: Text("Cüzdana bakiye yükle")),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: horizontalSrollAnimation(
                        animationtext: Text(
                          widget.campaign.name,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
                    child: Text(
                      "${widget.campaign.limit} ₺ hedefin ${widget.campaign.currentMoney} ₺'si toplandı.",
                      style: TextStyle(color: Color(0xff5e5e5e)),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    height: 0,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                      child: Text("Bağışta bulunmak istediğiniz tutarı giriniz")
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: 60,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: paycontoller,
                          style: TextStyle(
                              fontSize: 22,
                          ),
                        ),
                      ),
                      Text(
                        "₺",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7f0000),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 75,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 12,right: 12,bottom: 30),
                    child: ElevatedButton(onPressed: () async{
                      var req= await payApi.paytocampaign(userprovider, widget.campaign.id, paycontoller.text);
                      print(req);
                    },
                        child: Text("Bağışta bulun"),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
