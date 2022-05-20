import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../API/CampaignApiService.dart';
import '../API/ModelCampaign.dart';
import 'CampaignDetailPage.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  Campaignmodel orgmodel = new Campaignmodel();
  void _getData() async {
    orgmodel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
  @override
  void initState() {
    _getData();
    super.initState();
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
                  pageBuilder: (c, a1, a2) => CampaignDetailPage(orgmodel.data![index]),
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2,
                                      color: Color(0xffe6e5ea)
                                  )
                              )
                          ),
                          child: Hero(
                            tag: "orgpic"+orgmodel.data![index].name,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("lib/pictures/${orgmodel.data![index].photoUrl}"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              orgmodel.data![index].name,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Mert Çelik tarafından  ${orgmodel.data![index].city}",
                            style: TextStyle(
                              color: Color(0xff5e5e5e),

                            ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
