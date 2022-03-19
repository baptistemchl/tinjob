import 'package:badges/badges.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:koukicons/about.dart';
import 'package:koukicons/acceptDatabase.dart';
import 'package:tinjob/model/airtable_data_candidate.dart';
import 'package:tinjob/model/airtable_data_company.dart';
import 'package:tinjob/service/airtable_data_candidate_http.dart';
import 'package:tinjob/service/airtable_data_company_http.dart';
import 'package:tinjob/styles/style.dart';
import 'package:tinjob/widgets/widget_buttons_home.dart';
import 'package:tinjob/widgets/widget_drawer.dart';
import 'package:tinjob/widgets/widget_profil_card.dart';
import 'package:koukicons/approve.dart';
import 'package:koukicons/badDecision.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AirtableDataCompanyHttp airtableData = AirtableDataCompanyHttp();
  final AirtableDataCandidateHttp airtableDataCandidate =
      AirtableDataCandidateHttp();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
                title: const Text('Accueil'),
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Color.fromARGB(255, 48, 118, 146)),
            drawer: drawer(context),
            backgroundColor: const Color.fromRGBO(246, 243, 240, 1),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    profileCard(),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 48, 118, 146)),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0)),
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              margin: const EdgeInsets.only(
                                  top: 40.0, bottom: 40.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/settings');
                                              },
                                              child: buttonsHome(
                                                Image.asset(
                                                  'assets/ICON_settings.png',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/swipe');
                                                },
                                                child: FutureBuilder(
                                                  future: airtableDataCandidate
                                                      .getCandidateWaiting(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              List<
                                                                  AirtableDataCandidate>>
                                                          snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<AirtableDataCandidate>?
                                                          value = snapshot.data;
                                                      int length =
                                                          value!.length;
                                                      return Badge(
                                                        badgeColor:
                                                            Color.fromARGB(255,
                                                                0, 183, 255),
                                                        position: BadgePosition
                                                            .topEnd(
                                                                top: 0, end: 0),
                                                        badgeContent: Text(
                                                            length.toString()),
                                                        child: buttonsHome(
                                                          Image.asset(
                                                            'assets/ICON_attente.png',
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                  },
                                                )),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/refus');
                                                },
                                                child: FutureBuilder(
                                                  future: airtableDataCandidate
                                                      .getCandidateRefuse(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              List<
                                                                  AirtableDataCandidate>>
                                                          snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<AirtableDataCandidate>?
                                                          value = snapshot.data;
                                                      int length =
                                                          value!.length;
                                                      return Badge(
                                                        position: BadgePosition
                                                            .topEnd(
                                                                top: 0, end: 0),
                                                        badgeContent: Text(
                                                            length.toString()),
                                                        child: buttonsHome(
                                                          Image.asset(
                                                            'assets/ICON_refuse.png',
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                  },
                                                )),
                                          ],
                                        ),
                                      ]),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/about');
                                              },
                                              child: buttonsHome(
                                                Image.asset(
                                                  'assets/ICON_apropos.png',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/stats');
                                              },
                                              child: buttonsHome(
                                                Image.asset(
                                                  'assets/ICON_stats.png',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/admis');
                                                },
                                                child: FutureBuilder(
                                                  future: airtableDataCandidate
                                                      .getCandidateAdmis(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              List<
                                                                  AirtableDataCandidate>>
                                                          snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<AirtableDataCandidate>?
                                                          value = snapshot.data;
                                                      int length =
                                                          value!.length;
                                                      return Badge(
                                                        badgeColor:
                                                            Color.fromARGB(
                                                                255, 9, 255, 1),
                                                        position: BadgePosition
                                                            .topEnd(
                                                                top: 0, end: 0),
                                                        badgeContent: Text(
                                                            length.toString()),
                                                        child: buttonsHome(
                                                          Image.asset(
                                                            'assets/ICON_admis.png',
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                  },
                                                ))
                                          ],
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ))));
  }
}
