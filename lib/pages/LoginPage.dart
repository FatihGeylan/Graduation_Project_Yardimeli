import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/Model/ModelAuth.dart';
import 'package:yardimeliflutter/HomeScreen.dart';

import '../API/AuthAPI.dart';
import '../authprovider.dart';
import 'CreateUserPage.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  String email = '';
  String password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                  Text('Hoşgeldiniz! Lütfen Giriş Yapınız.',style: TextStyle(color: Color(0xff7f0000),fontSize: 22),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/7,
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
                              return 'Lütfen mail adresinizi girin..';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Mail Adresinizi Giriniz..',
                              labelText: 'ornek@gmail.com'),
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
                          onChanged: (String text) {
                            password = text;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Şifre giriniz..',
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/10,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.height/5,
                          child: ElevatedButton(
                            onPressed:() async{
                              {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Padding(
                                        padding: EdgeInsets.only(left: 130 , right: 130),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        )
                                    );
                                  },
                                );
                                if(_formKey.currentState!.validate()){
                                  try{
                                    var req = await
                                    _authAPI.login(_emailController.text,  _passwordController.text);
                                    Navigator.pop(context);
                                    var decoded=json.decode(req.body);
                                    if (decoded['resultStatus']  == 0) {
                                      print(req.body);
                                      authprovider.auth =
                                      Auth.fromReqBody(req.body);
                                      //user.printAttributes();
                                      _gotoHomeScreen(context);
                                    }
                                    else{
                                      showDialog(
                                        context: context,
                                        builder: (context)=>AlertDialog(
                                          content: Text("Kullanıcı adı veya şifre hatalı"),
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
                                      //print('Hatalı giriş falan');
                                    }
                                    // if(req.statusCode == 200){
                                    //   print(req.body);
                                    //   userprovider.user =
                                    //   User.fromReqBody(req.body);
                                    //   //user.printAttributes();
                                    //   _gotoHomeScreen(context);
                                    // } else {
                                    //   print('Hatalı giriş falan');
                                    // }
                                  } on Exception catch (e){
                                    print(e.toString());
                                    // pushError(context);
                                  }
                                }
                              }
                            }, child: Text('Giriş Yap'),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/60,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.height/5,
                          child: ElevatedButton(
                              onPressed: () {
                                _gotoCreateUserPage(context);
                              },
                              child: const Text('Kullanıcı Oluştur')

                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/60,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.height/5,
                          child: ElevatedButton(onPressed: () {
                            _gotoHomeScreen(context);
                          },
                              child: Text('TEST')),
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

  void _gotoHomeScreen(BuildContext context){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
    );
  }
  void _gotoCreateUserPage(BuildContext context){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CreateUserPage()),
          (Route<dynamic> route) => false,
    );
  }
}

