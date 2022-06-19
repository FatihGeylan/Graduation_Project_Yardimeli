import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:yardimeliflutter/API/AddCampaignApiService.dart';
import 'package:yardimeliflutter/Model/ModelCampaign.dart';
import 'package:yardimeliflutter/authprovider.dart';

import '../HomeScreen.dart';
import '../campaignpagestate.dart';
import 'CampaignDetailPage.dart';

class AddCampaignPage extends ConsumerStatefulWidget {
  const AddCampaignPage({Key? key}) : super(key: key);

  @override
  _AddCampaignPageState createState() => _AddCampaignPageState();
}

class _AddCampaignPageState extends ConsumerState<AddCampaignPage> {

  final TextEditingController _campaignNameController = TextEditingController();
  final TextEditingController _campaignDescriptionController = TextEditingController();
  final TextEditingController _campaignGoalController = TextEditingController();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  addCampaignApiService _addCampaignAPI = addCampaignApiService();
  String campaignName = '';
  String campaignDescription = '';
  String campaignGoal = '';
  final maxLines = 5;
  int selectedCategoryID = 3;
  String dropdownValue = 'Ankara';
  var seen = Set<String>();
  Future<Campaign>? _futureCampaign;
  var isimageselected=false;
  File? image;

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
  // List<String> uniquelist = cities.where((country) => seen.add(country)).toList();

  @override
  Widget build(BuildContext context) {


    // String dropdownValue = 'Şehrinizi Seçiniz.';
    final authprovider = ref.watch(authProvider);
    final campaignprovider = ref.watch(campaignpageProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
            child: Text(
              'İstanbul',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Form(
          key: _formKey2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async{
                    try{
                      final image =await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(image!=null){

                        final imagetemp=File(image.path);

                        // final directory=await getApplicationDocumentsDirectory();
                        // final name=basename(image.path);
                        // final imagep=File('${directory.path}/$name');
                        // final imagetemp=await File(image.path).copy(imagep.path);

                        setState(()=> this.image=imagetemp);
                      }
                    }on PlatformException catch(e){
                      print(e);
                    }

                  },
                  child: Container(
                    color: Color(0xffd1d1d1),
                    width: double.infinity,
                    height: 200,
                    child: image!=null?Image.file(
                        image!,
                      fit: BoxFit.fitWidth,
                    ):Center(child: Icon(Icons.add)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff7f0000),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: MediaQuery.of(context).size.height / 7,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        Text(
                          'Kampanyanız için bir kategori seçin.',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 50),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 18,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  campaignprovider.selectcategorybutton.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    ref
                                        .read(campaignpageProvider)
                                        .CategorySelect(index);
                                    selectedCategoryID = index + 1;
                                    //campaignprovider.CategorySelect(index);
                                  },
                                  child: campaigncategorylabel(
                                    text: index == 0
                                        ? Text(" Sağlık")
                                        : index == 1
                                            ? Text(" Eğitim")
                                            : Text(" Sokak Hayvanları"),
                                    icon: index == 0
                                        ? Icon(Icons.favorite_border)
                                        : index == 1
                                            ? Icon(Icons.school_outlined)
                                            : Icon(Icons.pets_outlined),
                                    color: index == 0 &&
                                            campaignprovider
                                                .selectcategorybutton[0]
                                        ? Colors.redAccent.shade100
                                        : index == 0 &&
                                                !campaignprovider
                                                    .selectcategorybutton[0]
                                            ? Colors.white
                                            : index == 1 &&
                                                    campaignprovider
                                                        .selectcategorybutton[1]
                                                ? Colors.lightBlueAccent.shade100
                                                : index == 1 &&
                                                        !campaignprovider
                                                                .selectcategorybutton[
                                                            1]
                                                    ? Colors.white
                                                    : index == 2 &&
                                                            campaignprovider
                                                                    .selectcategorybutton[
                                                                2]
                                                        ? Colors
                                                            .greenAccent.shade100
                                                        : Colors.white,
                                    bordercolor: index == 0 &&
                                            campaignprovider
                                                .selectcategorybutton[0]
                                        ? Colors.redAccent.shade100
                                        : index == 0 &&
                                                !campaignprovider
                                                    .selectcategorybutton[0]
                                            ? Colors.white
                                            : index == 1 &&
                                                    campaignprovider
                                                        .selectcategorybutton[1]
                                                ? Colors.lightBlueAccent.shade100
                                                : index == 1 &&
                                                        !campaignprovider
                                                                .selectcategorybutton[
                                                            1]
                                                    ? Colors.white
                                                    : index == 2 &&
                                                            campaignprovider
                                                                    .selectcategorybutton[
                                                                2]
                                                        ? Colors
                                                            .greenAccent.shade100
                                                        : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9.0),
                  child: TextFormField(
                    controller: _campaignNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (String text) {
                      campaignName = text;
                    },
                    decoration: InputDecoration(
                      labelText: 'Kampanya ismini giriniz.',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).errorColor
                            : Colors.black;
                        return TextStyle(color: color, letterSpacing: 1.3);
                      }),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xff7f0000)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xff7f0000)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9.0),
                  child: Container(
                    height: maxLines * 24.0,
                    child: TextFormField(
                      maxLines: maxLines,
                      controller: _campaignDescriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (String text) {
                        campaignDescription = text;
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Kampanya açıklamasını giriniz.',
                        labelStyle: MaterialStateTextStyle.resolveWith(
                            (Set<MaterialState> states) {
                          final Color color = states.contains(MaterialState.error)
                              ? Theme.of(context).errorColor
                              : Colors.black;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Color(0xff7f0000)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Color(0xff7f0000)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 51,
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_downward,
                        color: Color(
                          0xff7f0000,
                        )),

                    elevation: 16,

                    style: const TextStyle(
                        color: Color(
                          0xff7f0000,
                        ),
                        fontSize: 18),

                    // hint: Text(
                    //   '  Şehrinizi seçiniz.',
                    //   style: TextStyle(letterSpacing: 1.3, color: Colors.black),
                    // ),
                    underline: Container(
                      height: 2,
                      color: Color(0xff7f0000),
                    ),
                    onChanged: (city) {
                      setState(() {
                        dropdownValue = city!;
                      });
                    },
                    items: cities.map((String cities) {
                      return DropdownMenuItem<String>(
                        value: cities,
                        child: Text(cities),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9.0),
                  child: TextFormField(
                    controller: _campaignGoalController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (String text) {
                      campaignGoal = text;
                    },
                    decoration: InputDecoration(
                      labelText: 'Hedeflenen tutar giriniz.',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).errorColor
                            : Colors.black;
                        return TextStyle(color: color, letterSpacing: 1.3);
                      }),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xff7f0000)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xff7f0000)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () async {
                        {
                          if (_formKey2.currentState!.validate()&&image!=null) {
                              showDialog(
                                  context: context,
                                  builder: (context)=>AlertDialog(
                                      content: Text("Kampanya bilgileri oluşturulduktan sonra değiştirilemez."),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("geri dön")),
                                        ElevatedButton(
                                            onPressed: () async{
                                              final directory=await getApplicationDocumentsDirectory();
                                              final name=basename(image!.path);
                                              final imagep=File('${directory.path}/$name');
                                              final imagetemp=await File(image!.path).copy(imagep.path);

                                              var req = await _addCampaignAPI.AddCampaign(
                                                  authprovider,
                                                  _campaignNameController.text,
                                                  _campaignDescriptionController.text,
                                                  selectedCategoryID.toString(),
                                                  int.parse(_campaignGoalController.text),
                                                  image!.path,
                                                  dropdownValue
                                              );
                                              var decoded=json.decode(req!.body);
                                              Navigator.pop(context);
                                              if(decoded['resultStatus']  == 0){
                                                showDialog(
                                                  context: context,
                                                  builder: (context)=>AlertDialog(
                                                    content: Text("Kampanya oluşturuldu."),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text("kapat")
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => HomeScreen()),
                                                                  (Route<dynamic> route) => false,
                                                            );
                                                          },
                                                          child: Text("Ana sayfaya dön")
                                                      ),
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
                                                    content: Text("Kampanya oluşturulamadı"),
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
                                              // if(req?.statusCode ==200){
                                              //   print(req?.body);
                                              // }

                                            },
                                            child: Text("Kampanyamı oluştur")),
                                      ]
                              ));

                          }
                        }
                      },
                      child: Text(
                        'KAMPANYAMI OLUŞTUR',
                        style: TextStyle(fontSize: 16),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _gotoHomeScreen(BuildContext context){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
    );
  }
}
