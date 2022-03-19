import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tinjob/model/airtable_data_company.dart';
import 'package:tinjob/service/airtable_data_company_http.dart';
import 'package:tinjob/styles/style.dart';

Widget avatarCard() {
  final AirtableDataCompanyHttp airtableData = AirtableDataCompanyHttp();
  return FutureBuilder(
    future: airtableData.getCompany(),
    builder:
        (BuildContext context, AsyncSnapshot<AirtableDataCompany> snapshot) {
      if (snapshot.hasData) {
        AirtableDataCompany? value = snapshot.data;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProfileAvatar(
              '',
              child: Image.network(value!.logo),
              radius: 60,
              imageFit: BoxFit.none,
            ),
          ],
        );
      } else {
        // return Text('${snapshot.error}');
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}
