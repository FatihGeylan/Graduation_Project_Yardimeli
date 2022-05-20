import 'package:flutter/material.dart';
import 'package:yardimeliflutter/pages/MyCampaignsPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("Kullanıcı Adı",style: TextStyle(fontSize: 25,color: Color(0xff7f0000),fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("Bakiye = 0",style: TextStyle(fontSize: 25,color: Color(0xff7f0000),fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _myCampaignsPage(context);
                      },
                      child: Text('Kampanyalarım'),

                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: Text('Bakiye Yükle'),
                    ),
                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }

  void _myCampaignsPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const MyCampaignsPage();
    },));
  }
}
