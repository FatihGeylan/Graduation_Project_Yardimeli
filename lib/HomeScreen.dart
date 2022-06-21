import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yardimeliflutter/pages/CampaignPage.dart';
import 'package:yardimeliflutter/pages/LoginPage.dart';
import 'package:yardimeliflutter/pages/OrganizationPage.dart';
import 'package:yardimeliflutter/pages/ProfilePage.dart';

import 'authprovider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex=0;
  final pages =[
    CampaignPage(),
    OrganizationPage(),
    ProfilePage()
  ];
  Authstate authstate=new Authstate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
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
        actions: [
            ...[Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context)=>AlertDialog(
                        content: Text("Çıkış yapmak üzeresiniz"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Kapat")
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                authstate.auth!.accessToken = "";
                                Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context)=>AlertDialog(
                                      content: Text("Giriş Ekranına Yönlendiriyorsunuz"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(builder: (context) => LoginPage()),
                                                    (Route<dynamic> route) => false,
                                              );
                                            },
                                            child: Text("kapat")
                                        ),
                                      ],
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                    ),
                                  );
                                  //Navigator.pop(context);

                              },
                              child: Text("Onayla")
                          ),
                        ],
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      ),
                    );

                  },
                  child: Icon(
                      Icons.logout
                  ),
                )
            )]
        ],
       backgroundColor: Color(0xff7f0000),
      ),
      body: IndexedStack(
        index: currentindex,
        children: pages,
      ),
      bottomNavigationBar:BottomNavigationBar(
        selectedItemColor: Color(0xff7f0000),
        unselectedItemColor: Color(0xff926d6d),
        selectedFontSize: 10,
        unselectedFontSize: 12,
        selectedIconTheme: IconThemeData(
          size:40
        ),
        unselectedIconTheme: IconThemeData(
          size: 30
        ),
        currentIndex: currentindex,
        iconSize: 40,

        onTap: (index){
          setState(() {
            currentindex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
            label: "Kampanya",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house_siding),
            label: "Organizasyon",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),

        ],

      ) ,
    );
  }


}
