import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/material.dart';
import 'package:tinjob/model/airtable_data_candidate.dart';
import 'package:tinjob/screen/candidateDetail.dart';
import 'package:tinjob/service/airtable_data_candidate_http.dart';

class RefusScreen extends StatefulWidget {
  const RefusScreen({Key? key}) : super(key: key);

  @override
  _RefusScreenState createState() => _RefusScreenState();
}

class _RefusScreenState extends State<RefusScreen> {
  final AirtableDataCandidateHttp airtableDataCandidate =
      AirtableDataCandidateHttp();
  List<BannerListTile> bannerListTiles = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 222, 222, 248),
        appBar: AppBar(
            title: const Text("Candidats refusés"),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(255, 48, 118, 146)),
        body: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          width: width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: airtableDataCandidate.getCandidateRefuse(),
            builder: (BuildContext context,
                AsyncSnapshot<List<AirtableDataCandidate>> snapshot) {
              if (snapshot.hasData) {
                List<AirtableDataCandidate>? values = snapshot.data;
                return Column(
                  children: values!
                      .map(
                        (AirtableDataCandidate value) => BannerListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CandidateDetail(candidate: value)));
                          },
                          margin: EdgeInsets.all(10),
                          bannerText: "Refusé",
                          bannerPositionRight: false,
                          borderRadius: BorderRadius.circular(8),
                          randomBackgroundColor: false,
                          backgroundColor: Color.fromARGB(255, 48, 118, 146),
                          bannerTextColor: Color.fromARGB(255, 255, 255, 255),
                          elevation: 10.0,
                          imageContainer:
                              Image.network(value.photo, fit: BoxFit.cover),
                          title: Text(
                            value.nom,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: Text(value.statut,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ),
                      )
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          // Column(
          //   children: [
          //     const SizedBox(height: 4),
          //     //

          //   ],
          // ),
        ));
  }
}
