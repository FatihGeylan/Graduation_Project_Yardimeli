import 'package:flutter/material.dart';
import 'package:yardimeliflutter/pages/AddCampaignPage.dart';

class MyCampaignsPage extends StatefulWidget {
  const MyCampaignsPage({Key? key}) : super(key: key);

  @override
  State<MyCampaignsPage> createState() => _MyCampaignsPageState();
}

class _MyCampaignsPageState extends State<MyCampaignsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
          child: Text('Yardım Eli',style: const TextStyle(color: Colors.white),),
        ),
      ),
      body: Column(
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
              height: 200,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                      'Henüz bir kampanya oluşturmamışsınız. Hemen bir yardım eli bulmak için kampanya başlatabilirsiniz.'
                  ,style: TextStyle(fontSize: 20,color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                         elevation: 20
                      ),
                      onPressed: () {
                        _addCampaignPage(context);
                      },
                      child: Text('Kampanya Ekle',style: TextStyle(color: Color(0xff7f0000)),)
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addCampaignPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const AddCampaignPage();
    },));
  }
}
