import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/pages/ChangeCityPage.dart';
import 'package:yardimeliflutter/pages/MyCampaignsPage.dart';

import '../UserProvider.dart';
import '../authprovider.dart';
import 'addbalancePage.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Authstate authstate=new Authstate();
  @override
  void initState() {
    // final authprovider = ref.watch(authProvider);
    ref.read(userProvider).getUser(authstate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final authprovider = ref.watch(authProvider);
    final userprovider = ref.watch(userProvider);
    //ref.read(userProvider).getUser(authprovider);
    return Scaffold(
        body:
        userprovider.user == null //||
        //userprovider.user.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  ref.read(userProvider).getUser(authstate);
                },
                child:
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 25),
                      child: Material(
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ListTile(
                              //   dense: true,
                              //   minLeadingWidth: 10,
                              //   leading: Icon(
                              //      Icons.account_circle,
                              //         size: 25,
                              //         color: Color(0xff7f0000),
                              //   ),
                              //   title: RichText(
                              //     text: TextSpan(
                              //       children: [
                              //         TextSpan(
                              //             text: userprovider.user!.FirstName+" "+userprovider.user!.LastName,
                              //             style: TextStyle(
                              //               fontSize: 25,
                              //               color: Color(0xff7f0000),
                              //               fontWeight: FontWeight.bold,
                              //             )),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 16,
                                    right: 16),
                                child: Text(userprovider.user!.UserName,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Color(0xff7f0000),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Divider(
                                thickness: 2,
                                color: Color(0xff7f0000),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.account_circle,
                                              size: 25,
                                              color: Color(0xff7f0000)),
                                        ),
                                        TextSpan(
                                            text: "  " +userprovider.user!.FirstName+" "+userprovider.user!.LastName,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xff7f0000),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                  )
                              ),
                              Divider(
                                thickness: 2,
                                color: Color(0xff7f0000),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.mail,
                                              size: 25,
                                              color: Color(0xff7f0000)),
                                        ),
                                        TextSpan(
                                            text: "  " +userprovider.user!.Email,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xff7f0000),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                  )
                              ),
                              Divider(
                                thickness: 2,
                                color: Color(0xff7f0000),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
                                  child: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(Icons.location_city,
                                                  size: 25,
                                                  color: Color(0xff7f0000)),
                                            ),
                                            TextSpan(
                                                text: "  " + userprovider.user!.City,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Color(0xff7f0000),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.edit_location_rounded, size: 25,color: Color(0xff7f0000)),
                                        onPressed: () {
                                          _changeCityPAge(context);
                                        },
                                      )
                                    ],
                                  ),

                              ),
                              Divider(
                                thickness: 2,
                                color: Color(0xff7f0000),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                              Icons.account_balance_wallet,
                                              size: 22,
                                              color: Color(0xff7f0000)),
                                        ),
                                        TextSpan(
                                            text: "  ${userprovider.user!.Balance}",
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xff7f0000),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                  )

                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/13,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: [

                            Container(


                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) =>
                                          addbalacePage(),
                                      transitionsBuilder:
                                          (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 300),
                                    ),
                                  );
                                },
                                child: Text('Bakiye Yükle'),
                              ),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height/11,
                              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 16.0),
                            ),

                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height/11,
                              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _myCampaignsPage(context);
                                },
                                child: Text('Kampanyalarım'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  void _myCampaignsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const MyCampaignsPage();
      },
    ));
  }
  void _changeCityPAge(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const ChangeCityPage();
      },
    ));
  }
}
