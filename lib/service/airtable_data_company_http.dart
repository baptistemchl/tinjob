import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tinjob/model/airtable_data_company.dart';
import 'package:tinjob/utils/config.dart';

class AirtableDataCompanyHttp {
  final Uri urlCompany = Uri.https(
    "api.airtable.com",
    "/v0/${Config.airtableProjectBase}/entreprise/recXfjnGTz561X8b0",
  );

  Future<AirtableDataCompany> getCompany() async {
    final res = await http.get(
      urlCompany,
      headers: {"Authorization": "Bearer ${Config.airtableApikey}"},
    );
    if (res.statusCode == 200) {
      return AirtableDataCompany.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load Company');
    }
  }
}
