import 'package:flutter/material.dart';
import 'package:yardimeliflutter/Model/ModelOganization.dart';

class OrganizationDetailPage extends StatelessWidget {
  final Organization organization;
  const OrganizationDetailPage(this.organization, {Key? key}) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2,
                                    color: Color(0xffe6e5ea)
                                )
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: "orgpic" + organization.photoUrl,
                                child: Image.asset(
                                  "lib/pictures/${organization.photoUrl}",
                                  height: 150,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Text(organization.name,
                          style:TextStyle(
                            fontSize: 20
                          ) ,
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      Text(
                          "Yeşilay, insan onurunu ve saygınlığını temel alan, toplumu ve gençliği ayrım gözetmeden zararlı "
                              "alışkanlıklardan korumak için çalışan, milli ve ahlaki değerleri gözeterek ve bilimsel metotlar kullanarak "
                              "tütün(sigara), alkol, uyuşturucu madde, teknoloji, kumar vb. bağımlılıklarla mücadele eden; önleyici ve "
                              "rehabilite edici halk sağlığı ve savunuculuk çalışmaları yürüten bir sivil toplum kuruluşudur."
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.bottomCenter,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
