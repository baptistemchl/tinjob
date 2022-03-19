// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tinjob/model/airtable_data_candidate.dart';
import 'package:flutter/material.dart';
import 'package:tinjob/screen/cvDetail.dart';
import 'package:tinjob/widgets/widget_buttons_home.dart';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:tinjob/widgets/widget_drawer.dart';

class CandidateDetail extends StatelessWidget {
  final AirtableDataCandidate candidate;
  List<AirtableDataCandidate> candidatesDatas = [];
  CandidateDetail({required this.candidate});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new Stack(
      children: <Widget>[
        new Container(
          color: Color.fromARGB(255, 48, 118, 146),
        ),
        new Image.network(
          candidate.photo,
          fit: BoxFit.fill,
        ),
        new BackdropFilter(
            filter: new ui.ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: new Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(120, 48, 118, 146),
              ),
            )),
        new Scaffold(
            appBar: new AppBar(
              title: new Text(candidate.nom + ' ' + candidate.prenom),
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: new Center(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: _height / 12,
                  ),
                  new CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: NetworkImage(candidate.photo),
                  ),
                  new SizedBox(
                    height: _height / 25.0,
                  ),
                  new Text(
                    candidate.nom + ' ' + candidate.prenom,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: Colors.white),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                    child: new Text(
                      candidate.statut,
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  new Divider(
                    height: _height / 30,
                    color: Colors.white,
                  ),
                  new Column(children: <Widget>[
                    Row(children: <Widget>[
                      rowCell('Email :', candidate.mail),
                    ]),
                    new Divider(height: _height / 30, color: Colors.white),
                    IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          rowCell('Telephone :', candidate.telephone),
                          const VerticalDivider(width: 20, color: Colors.white),
                          rowCell('Localisation :', candidate.localisation),
                        ],
                      ),
                    ),
                  ]),
                  new Divider(height: _height / 30, color: Colors.white),
                  new Padding(
                    padding: new EdgeInsets.only(
                        left: _width / 8, right: _width / 8),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              RealisationScreen(candidate: candidate)));
                    },
                    child: Column(children: [
                      Image.asset(
                        'assets/ICON_realisation.png',
                      ),
                      const Text(
                        'Réalisations',
                        style: TextStyle(color: Colors.white),
                      ),
                    ]),
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget rowCell(String type, String coords) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(
            '$type',
            style: const TextStyle(color: Colors.white),
          ),
          new Text(coords,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}
