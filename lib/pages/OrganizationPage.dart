import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yardimeliflutter/pages/OrganizationDetailPage.dart';

import '../Model/ModelOganization.dart';
import '../API/OrganizationApiService.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({Key? key}) : super(key: key);

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  late int selected;
  Organizationmodel orgmodel = new Organizationmodel();
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    orgmodel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orgmodel.data == null || orgmodel.data!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(

              itemCount: orgmodel.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => OrganizationDetailPage(orgmodel.data![index]),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) {return OrganizationDetailPage(orgmodel.data![index]);},));
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: Color(0xffe6e5ea)
                                      )
                                    )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: "orgpic"+orgmodel.data![index].photoUrl,
                                        child: Image.asset(
                                          "lib/pictures/${orgmodel.data![index].photoUrl}",
                                          height: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      orgmodel.data![index].shortName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(
                                        orgmodel.data![index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },

            ),
    );
  }
}
