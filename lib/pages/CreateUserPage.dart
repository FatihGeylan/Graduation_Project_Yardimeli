import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/API/CreateUserApiService.dart';
import 'package:yardimeliflutter/Model/ModelAuth.dart';
import 'package:yardimeliflutter/HomeScreen.dart';

import '../API/AuthAPI.dart';
import '../authprovider.dart';
import 'LoginPage.dart';


class CreateUserPage extends ConsumerStatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends ConsumerState<CreateUserPage> {

  String email = '';
  String password = '';
  String dropdownValue = 'Ankara';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  CreateUserApiService _createUserAPI = CreateUserApiService();

  // bool _success = false;
  // String _userEmail= '';
  AuthAPI _authAPI = AuthAPI();

  @override
  Widget build(BuildContext context) {
    final authprovider = ref.watch(authProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
            child: Text('Yardım Eli',style: const TextStyle(color: Colors.white),),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.width/7,
                  ),
                  Text('Kullanıcı Oluşturunuz.',style: TextStyle(color: Color(0xff7f0000),fontSize: 22),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/20*15,

                    // height: 200.0,
                    //decoration: const BoxDecoration(color: Colors.blueGrey),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (String text) {
                            email = text;
                          },
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen mail giriniz..';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Mail Adresinizi Giriniz..',
                              ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen Şifre Giriniz';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Şifre giriniz..',
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/40,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen kullanıcı adınızı girin.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Kullanıcı Adınızı Giriniz..',
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/40,
                        ),
                        TextFormField(
                          controller: _firstnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen adınızı girin.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Adınızı Giriniz..',
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/40,
                        ),
                        TextFormField(
                          controller: _lastnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen soyadınızı girin.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Soyadınızı Giriniz..',
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/40,
                        ),
                        Container(
                          height: 51,
                          width: double.infinity,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward,
                                // color: Color(
                                //   0xff7f0000,
                                // )
                            ),

                            elevation: 16,

                            style: const TextStyle(
                                color:
                                  Colors.black54,
                                fontSize: 18),

                            // hint: Text(
                            //   '  Şehrinizi seçiniz.',
                            //   style: TextStyle(letterSpacing: 1.3, color: Colors.black),
                            // ),
                            underline: Container(
                              height: 2,
                              color: Colors.black12,
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
                          height: MediaQuery.of(context).size.height/40,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.height/5,
                          child: ElevatedButton(
                            onPressed:() async{
                              {
                                if(_formKey.currentState!.validate()){
                                  try {
                                    var req = await _createUserAPI.CreateUser(
                                        dropdownValue,
                                        _firstnameController.text,
                                        _lastnameController.text,
                                        _usernameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                    );

                                    if(req?.statusCode ==200){
                                      print(req?.body);
                                      _gotoLoginPage(context);
                                    }

                                    else {
                                      print('KULLANICI OLUSTURULAMADI');
                                    }
                                  } on Exception catch (e) {
                                    print(e.toString());
                                    print('KULLANICI OLUSTURULAMADI');
                                    // pushError(context);
                                  }
                                }
                              }
                            }, child: Text('Kullanıcı Oluştur'),
                          ),
                        ),
                        SizedBox(height: 25),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _gotoLoginPage(BuildContext context){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }
}
