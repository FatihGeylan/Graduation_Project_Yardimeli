import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yardimeliflutter/pages/OrganizationDetailPage.dart';

import '../API/ModelOganization.dart';
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return OrganizationDetailPage(orgmodel.data![index]);
                    },));

                  },
                  child: Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "lib/pictures/${orgmodel.data![index].photoUrl}",
                                    height: 120,
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
                                const SizedBox(
                                  height: 16,
                                )
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
