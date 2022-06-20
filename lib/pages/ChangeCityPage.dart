import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/pages/AddCampaignPage.dart';
import 'package:yardimeliflutter/pages/ProfilePage.dart';

import '../API/ChangeCityApiService.dart';
import '../UserProvider.dart';
import '../authprovider.dart';

class ChangeCityPage extends ConsumerStatefulWidget {
  const ChangeCityPage({Key? key}) : super(key: key);

  @override
  _ChangeCityPageState createState() => _ChangeCityPageState();
}

class _ChangeCityPageState extends ConsumerState<ChangeCityPage> {
  List<String> cities = ['Adana','Adıyaman','Afyon','Ağrı','Amasya','Ankara','Antalya','Artvin','Aydın','Balıkesir',
    'Bilecik','Bingöl','Bitlis','Bolu','Burdur', 'Bursa','Çanakkale','Çankırı','Çorum','Denizli',
    'Diyarbakır','Edirne','Elazığ','Erzincan','Erzurum','Eskişehir','Gaziantep','Giresun','Gümüşhane','Hakkari',
    'Hatay','Isparta','Mersin','İstanbul','İzmir','Kars','Kastamonu','Kayseri','Kırklareli','Kırşehir',
    'Kocaeli','Konya','Kütahya','Malatya','Manisa','Kahramanmaraş','Mardin','Muğla','Muş','Nevşehir',
    'Niğde','Ordu','Rize','Sakarya','Samsun','Siirt','Sinop','Sivas','Tekirdağ','Tokat',
    'Trabzon','Tunceli','Şanlıurfa','Uşak','Van','Yozgat','Zonguldak','Aksaray','Bayburt','Karaman',
    'Kırıkkale','Batman','Şırnak','Bartın','Ardahan','Iğdır','Yalova','Karabük','Kilis','Osmaniye',
    'Düzce',
  ];
  String dropdownValue = 'Ankara';
  changeCityApi cityapi = changeCityApi();
  Authstate authstate=new Authstate();
  @override
  Widget build(BuildContext context) {
    //final userprovider = ref.watch(userProvider);
    final authprovider = ref.watch(authProvider);
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 200,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Bulunduğunuz Şehri Seçiniz'
                    ,style: TextStyle(fontSize: 20,color: Color(0xff7f0000,)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 51,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward,
                          color: Color(0xff7f0000,),
                      ),

                      elevation: 16,

                      style: const TextStyle(
                          color: Color(0xff7f0000,),
                          fontSize: 18),

                      // hint: Text(
                      //   '  Şehrinizi seçiniz.',
                      //   style: TextStyle(letterSpacing: 1.3, color: Colors.black),
                      // ),
                      underline: Container(
                        height: 2,
                        color: Color(0xff7f0000,),
                        // Color(
                        //   0xff7f0000,
                        // ),
                      ),
                      onChanged: (city) {
                        setState(() {
                          dropdownValue = city!;
                        });
                      },
                      items: cities.map((String cities) {
                        return DropdownMenuItem<String>(
                          value: cities,
                          child: Text(cities, style: TextStyle(color:
                          Color(0xff7f0000,),
                            //Colors.white,
                            )
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff7f0000,),
                          elevation: 20
                      ),
                      onPressed: () async {
                        var req;

                        req = await cityapi.changecity(authprovider, dropdownValue);

                        Navigator.pop(context);
                        if(!req){
                          showDialog(
                            context: context,
                            builder: (context)=>AlertDialog(
                              content: Text("Hata!! Şehir değiştirilemedi"),
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
                          ref.read(userProvider).getUser(authstate);
                          showDialog(
                            context: context,
                            builder: (context)=>AlertDialog(
                              content: Text("Şehriniz başarıyla değiştirildi."),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("kapat")
                                ),
                                // ElevatedButton(
                                //     onPressed: () {
                                //       Navigator.pushAndRemoveUntil(
                                //         context,
                                //         MaterialPageRoute(builder: (context) => ProfilePage()),
                                //             (Route<dynamic> route) => false,
                                //       );
                                //     },
                                //     child: Text("Profile dön")
                                // ),
                              ],
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            ),
                          );
                          //Navigator.pop(context);
                        }

                      },
                      child: Text('Şehrimi Değiştir',style: TextStyle(color: Colors.white),)
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _profilePage(BuildContext context){
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
  //     return const ProfilePage();
  //   },));
  // }
}