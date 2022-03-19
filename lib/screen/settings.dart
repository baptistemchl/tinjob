import 'package:flutter/material.dart';
import 'package:tinjob/service/airtable_data_company_http.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AirtableDataCompanyHttp airtableData = AirtableDataCompanyHttp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Paramètres'),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(255, 48, 118, 146)),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/IMG_commingsoon.png')])),
    );
  }
}
