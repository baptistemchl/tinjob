import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tinjob/model/airtable_data_candidate.dart';

import 'package:tinjob/model/airtable_data_company.dart';
import 'package:tinjob/utils/config.dart';

class AirtableDataCandidateHttp {
  final Uri urlCandidate = Uri.https(
    "api.airtable.com",
    "/v0/${Config.airtableProjectBase}/candidat",
    {"maxRecords": "500", "view": "Grid view"},
  );

  Future<List<AirtableDataCandidate>> getCandidate() async {
    final res = await http.get(
      urlCandidate,
      headers: {"Authorization": "Bearer ${Config.airtableApikey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson['records'];

      List<AirtableDataCandidate> values = [];
      data.forEach(
        (value) {
          dynamic realisations = value['fields']['realisation'];
          List<String> realist = [];
          realisations
              .forEach((realisation) => realist.add(realisation['url']));
          values.add(
            AirtableDataCandidate(
              id: value['id'],
              nom: value['fields']['nom'],
              prenom: value['fields']['prenom'],
              photo: value['fields']['photo'][0]['url'],
              statut: value['fields']['statut'],
              mail: value['fields']['mail'],
              localisation: value['fields']['localisation'],
              telephone: value['fields']['telephone'],
              match: value['fields']['match'],
              realisations: realist,
              lat: value['fields']['lat'].toDouble(),
              long: value['fields']['long'].toDouble(),
            ),
          );
        },
      );

      return values;
    } else {
      print('EEREUR');
      throw "ERROR !!!!!";
    }
  }

  // DELETE AIRTABLE CANDIDATE

  Future<String> deleteCandidate(String id) async {
    final response = await http.delete(
      Uri.https(
          "api.airtable.com", "/v0/${Config.airtableProjectBase}/candidat/$id"),
      headers: {"Authorization": "Bearer ${Config.airtableApikey}"},
      body: jsonEncode(<String, String>{}),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return id;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }

  // Update AIRTABLE CANDIDATE

  Future<String> updateCandidate(AirtableDataCandidate candidate) async {
    final response = await http.patch(
      Uri.https(
          "api.airtable.com", "/v0/${Config.airtableProjectBase}/candidat/"),
      headers: {
        "Authorization": "Bearer ${Config.airtableApikey}",
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "records": [
            {
              "id": candidate.id,
              "fields": {
                'match': candidate.match,
              }
            },
          ]
        },
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }

  // Select * from xxxx where xxxx

  Future<List<AirtableDataCandidate>> getCandidateWaiting() async {
    final res = await http.get(
      Uri.https(
        "api.airtable.com",
        "/v0/${Config.airtableProjectBase}/candidat",
        {'filterByFormula': 'SEARCH("En attente",{match})'},
      ),
      headers: {"Authorization": "Bearer ${Config.airtableApikey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson['records'];

      List<AirtableDataCandidate> values = [];
      data.forEach(
        (value) {
          dynamic realisations = value['fields']['realisation'];
          List<String> realist = [];
          realisations
              .forEach((realisation) => realist.add(realisation['url']));
          values.add(
            AirtableDataCandidate(
              id: value['id'],
              nom: value['fields']['nom'],
              prenom: value['fields']['prenom'],
              photo: value['fields']['photo'][0]['url'],
              statut: value['fields']['statut'],
              mail: value['fields']['mail'],
              localisation: value['fields']['localisation'],
              telephone: value['fields']['telephone'],
              match: value['fields']['match'],
              realisations: realist,
              lat: value['fields']['lat'].toDouble(),
              long: value['fields']['long'].toDouble(),
            ),
          );
        },
      );

      return values;
    } else {
      print('EEREUR');
      throw "ERROR !!!!!";
    }
  }

  // SELECT * FROM CANDIDATE REFUSE

  // Select * from xxxx where xxxx

  Future<List<AirtableDataCandidate>> getCandidateRefuse() async {
    final res = await http.get(
      Uri.https(
        "api.airtable.com",
        "/v0/${Config.airtableProjectBase}/candidat",
        {'filterByFormula': 'SEARCH("Refusé",{match})'},
      ),
      headers: {"Authorization": "Bearer ${Config.airtableApikey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson['records'];

      List<AirtableDataCandidate> values = [];
      data.forEach(
        (value) {
          dynamic realisations = value['fields']['realisation'];
          List<String> realist = [];
          realisations
              .forEach((realisation) => realist.add(realisation['url']));
          values.add(
            AirtableDataCandidate(
              id: value['id'],
              nom: value['fields']['nom'],
              prenom: value['fields']['prenom'],
              photo: value['fields']['photo'][0]['url'],
              statut: value['fields']['statut'],
              mail: value['fields']['mail'],
              localisation: value['fields']['localisation'],
              telephone: value['fields']['telephone'],
              match: value['fields']['match'],
              realisations: realist,
              lat: value['fields']['lat'].toDouble(),
              long: value['fields']['long'].toDouble(),
            ),
          );
        },
      );

      return values;
    } else {
      print('EEREUR');
      throw "ERROR !!!!!";
    }
  }

  // GET CANDIDAT ADMIS

  // Select * from xxxx where xxxx

  Future<List<AirtableDataCandidate>> getCandidateAdmis() async {
    final res = await http.get(
      Uri.https(
        "api.airtable.com",
        "/v0/${Config.airtableProjectBase}/candidat",
        {'filterByFormula': 'SEARCH("Admis",{match})'},
      ),
      headers: {"Authorization": "Bearer ${Config.airtableApikey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson['records'];

      List<AirtableDataCandidate> values = [];
      data.forEach(
        (value) {
          dynamic realisations = value['fields']['realisation'];
          List<String> realist = [];
          realisations
              .forEach((realisation) => realist.add(realisation['url']));
          values.add(
            AirtableDataCandidate(
              id: value['id'],
              nom: value['fields']['nom'],
              prenom: value['fields']['prenom'],
              photo: value['fields']['photo'][0]['url'],
              statut: value['fields']['statut'],
              mail: value['fields']['mail'],
              localisation: value['fields']['localisation'],
              telephone: value['fields']['telephone'],
              match: value['fields']['match'],
              realisations: realist,
              lat: value['fields']['lat'].toDouble(),
              long: value['fields']['long'].toDouble(),
            ),
          );
        },
      );

      return values;
    } else {
      print('EEREUR');
      throw "ERROR !!!!!";
    }
  }

  // COUNT
  Future<String> getCandidateCountWait() async {
    final res = await http.get(
      Uri.https(
        "api.airtable.com",
        "/v0/${Config.airtableProjectBase}/candidat",
        {'filterByFormula': 'COUNTALL("Admis",{match})'},
      ),
      headers: {"Authorization": "Bearer ${Config.airtableApikey}"},
    );
    print(res.body);
    if (res.statusCode == 200) {
      return 'res';
    } else {
      print('EEREUR');
      throw "ERROR !!!!!";
    }
  }
}
