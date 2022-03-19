import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tinjob/model/airtable_data_company.dart';
import 'package:tinjob/service/airtable_data_company_http.dart';
import 'package:tinjob/styles/style.dart';

Widget profileCard() {
  final AirtableDataCompanyHttp airtableData = AirtableDataCompanyHttp();
  return FutureBuilder(
    future: airtableData.getCompany(),
    builder:
        (BuildContext context, AsyncSnapshot<AirtableDataCompany> snapshot) {
      if (snapshot.hasData) {
        AirtableDataCompany? value = snapshot.data;
        return Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 48, 118, 146)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  bottomLeft: Radius.circular(35.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: const Color.fromARGB(255, 255, 255, 255)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProfileAvatar(
                  '',
                  child: Image.network(value!.logo),
                  radius: 35,
                  backgroundColor: Colors.white,
                  elevation: 5.0,
                  borderColor: Colors.black,
                  imageFit: BoxFit.none,
                ),
                const SizedBox(width: 10),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value.nom, style: textprofil),
                    const SizedBox(height: 5),
                    Text(
                      value.description,
                      style: textsousprofil,
                    ),
                  ],
                )),
              ],
            ));
      } else {
        // return Text('${snapshot.error}');
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}
