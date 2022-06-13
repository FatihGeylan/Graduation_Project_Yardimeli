import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/API/addbalanceApiService.dart';
import 'package:yardimeliflutter/authprovider.dart';


class addbalacePage extends ConsumerStatefulWidget {
  const addbalacePage({Key? key}) : super(key: key);

  @override
  _addbalacePageState createState() => _addbalacePageState();
}

class _addbalacePageState extends ConsumerState<addbalacePage> {
  addbalanceApi addbalance =addbalanceApi();
  final paycontoller=TextEditingController();
  void dispose() {
    paycontoller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final userprovider = ref.watch(authProvider);
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
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                              "Cüzdanınıza yüklemek istediğiniz tutarı giriniz."
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: IconButton( onPressed: () {
                                  paycontoller.text="";
                                }, icon: Icon(Icons.close),),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                width: 60,
                                child: TextField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*')),
                                  ],
                                  decoration:  InputDecoration(
                                    border:  OutlineInputBorder(),
                                    contentPadding: EdgeInsets.zero
                                  ),

                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  controller: paycontoller,
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "₺",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff7f0000),
                                ),
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          height: 75,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 12,right: 12,bottom: 30),
                          child: ElevatedButton(
                            onPressed: () async{
                              if(paycontoller.text!="" ){
                                showDialog(
                                  context: context,
                                  builder: (context)=>AlertDialog(
                                    content: Text("${paycontoller.text} ₺ tutarında cüzdana para yüklenecektir."),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("İptal et")),
                                      ElevatedButton(
                                          onPressed: () async{
                                            var req= await addbalance.addbalance(userprovider, paycontoller.text);
                                            Navigator.pop(context);
                                            if(!req){
                                              showDialog(
                                                context: context,
                                                builder: (context)=>AlertDialog(
                                                  content: Text("HATA bakiye yüklenemedi"),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("kapat")
                                                    )],
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                                ),
                                              );
                                            }
                                            else{
                                              showDialog(
                                                context: context,
                                                builder: (context)=>AlertDialog(
                                                  content: Text("Bakiye başarıyla yüklendi"),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("kapat")
                                                    )],
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text("Bakiye yükle")),
                                    ],
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                  ),
                                );
                              }
                              else{
                                showDialog(
                                  context: context,
                                  builder: (context)=>AlertDialog(
                                    content: Text("Lütfen tutar giriniz"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("kapat")
                                      )],
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                  ),
                                );

                              }


                            },
                            child: Text("Bakiye yükle"),),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
