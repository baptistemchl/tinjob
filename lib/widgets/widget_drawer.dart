import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tinjob/model/airtable_data_candidate.dart';
import 'package:tinjob/service/airtable_data_candidate_http.dart';
import 'package:tinjob/service/airtable_data_company_http.dart';
import 'package:tinjob/widgets/widget_avatar.dart';
import 'package:tinjob/widgets/widget_profil_card.dart';

final AirtableDataCompanyHttp airtableData = AirtableDataCompanyHttp();
final AirtableDataCandidateHttp airtableDataCandidate =
    AirtableDataCandidateHttp();
Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 48, 118, 146),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                child: avatarCard(),
              )
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                'assets/ICON_home_drawer.png',
              ),
              Text('Accueil'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/ICON_settings_drawer.png',
              ),
              Text('Paramètres'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/ICON_marker_drawer.png',
              ),
              Text('Localisation des candidats'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/map');
          },
        ),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/ICON_stats_drawer.png',
              ),
              Text('Vos statistiques'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/stats');
          },
        ),
        FutureBuilder(
          future: airtableDataCandidate.getCandidateWaiting(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AirtableDataCandidate>> snapshot) {
            if (snapshot.hasData) {
              List<AirtableDataCandidate>? value = snapshot.data;
              int length = value!.length;
              return Badge(
                badgeColor: Color.fromARGB(255, 0, 183, 255),
                position: BadgePosition.topEnd(top: 0, end: 100),
                badgeContent: Text(length.toString()),
                child: ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/ICON_cards_drawer.png',
                      ),
                      Text('Les candidats'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/swipe');
                  },
                ),
              );
            } else {
              return const Center(child: LinearProgressIndicator());
            }
          },
        ),
        FutureBuilder(
          future: airtableDataCandidate.getCandidateAdmis(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AirtableDataCandidate>> snapshot) {
            if (snapshot.hasData) {
              List<AirtableDataCandidate>? value = snapshot.data;
              int length = value!.length;
              return Badge(
                badgeColor: Color.fromARGB(255, 9, 255, 1),
                position: BadgePosition.topEnd(top: 0, end: 100),
                badgeContent: Text(length.toString()),
                child: ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/ICON_admis_drawer.png',
                      ),
                      Text('Candidats admis'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/admis');
                  },
                ),
              );
            } else {
              return const Center(child: LinearProgressIndicator());
            }
          },
        ),
        FutureBuilder(
          future: airtableDataCandidate.getCandidateRefuse(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AirtableDataCandidate>> snapshot) {
            if (snapshot.hasData) {
              List<AirtableDataCandidate>? value = snapshot.data;
              int length = value!.length;
              return Badge(
                position: BadgePosition.topEnd(top: 0, end: 100),
                badgeContent: Text(length.toString()),
                child: ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/ICON_refuse_drawer.png',
                      ),
                      Text('Candidats refusés'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/refus');
                  },
                ),
              );
            } else {
              return const Center(child: LinearProgressIndicator());
            }
          },
        ),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/ICON_apropos_drawer.png',
              ),
              Text('A propos'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/about');
          },
        ),
      ],
    ),
  );
}
