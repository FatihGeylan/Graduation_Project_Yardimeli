import 'package:flutter/material.dart';
import 'package:yardimeliflutter/API/ModelOganization.dart';

class OrganizationDetailPage extends StatelessWidget {
  final Organization organization;
  const OrganizationDetailPage(this.organization, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text("aaa"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
