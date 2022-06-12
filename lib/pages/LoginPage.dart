import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/Model/ModelAuth.dart';
import 'package:yardimeliflutter/HomeScreen.dart';

import '../API/AuthAPI.dart';
import '../authprovider.dart';


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
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Type your mail',
                              labelText: 'example@gmail.com'),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (String text) {
                            password = text;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Type your password',
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
                                if(_formKey.currentState!.validate()){
                                  try{
                                    var req = await
                                    _authAPI.login(_emailController.text,  _passwordController.text);
                                    if(req.statusCode == 200){
                                      print(req.body);
                                      authprovider.auth =
                                      Auth.fromReqBody(req.body);
                                      //user.printAttributes();
                                      _gotoHomeScreen(context);
                                    } else {
                                      print('Hatalı giriş falan');
                                    }
                                  } on Exception catch (e){
                                    print(e.toString());
                                    // pushError(context);
                                  }
                                }
                              }
                            }, child: Text('Sign in'),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/60,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.height/5,
                          child: ElevatedButton(
                              onPressed: () {
                                //_gotoCreateUser(context);
                              },
                              child: const Text('Create New User')

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
                              child: Text('Giris')),
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
}

