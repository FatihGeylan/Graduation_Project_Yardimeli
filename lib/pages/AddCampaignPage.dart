import 'package:flutter/material.dart';

class AddCampaignPage extends StatefulWidget {
  const AddCampaignPage({Key? key}) : super(key: key);

  @override
  State<AddCampaignPage> createState() => _AddCampaignPageState();
}

class _AddCampaignPageState extends State<AddCampaignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
          child: Text('Yardım Eli',style: const TextStyle(color: Colors.white),),
        ),
      ),
      body: Padding(
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
                  ),
                  onPressed: () {

                  },
                  child: Text('asdasdadssda Ekle',style: TextStyle(color: Color(0xff7f0000)),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
