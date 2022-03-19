// ignore_for_file: unnecessary_new

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:tinjob/model/airtable_data_candidate.dart';
import 'package:tinjob/screen/candidateDetail.dart';
import 'package:tinjob/service/airtable_data_candidate_http.dart';
import 'package:tinjob/widgets/widget_drawer.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({Key? key}) : super(key: key);

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen>
    with TickerProviderStateMixin {
  final AirtableDataCandidateHttp airtableData = AirtableDataCandidateHttp();

  List<String> welcomeImages = [];
  List<AirtableDataCandidate> candidatesDatas = [];

  setPictures() async {
    var candidates = await airtableData.getCandidateWaiting();
    for (var candidate in candidates) {
      setState(() {
        welcomeImages.add(candidate.photo);
        candidatesDatas.add(candidate);
      });
    }
  }

  @override
  void initState() {
    setPictures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
      appBar: AppBar(
          title: const Text('Les derniers candidats'),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(255, 48, 118, 146)),
      drawer: drawer(context),
      backgroundColor: const Color.fromRGBO(246, 243, 240, 1),
      body: new Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: new TinderSwapCard(
            swipeUp: false,
            swipeDown: false,
            orientation: AmassOrientation.BOTTOM,
            totalNum: welcomeImages.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 48, 118, 146)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CandidateDetail(
                            candidate: candidatesDatas[index])));
                  }, // Image tapped
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network("${welcomeImages[index]}",
                        fit: BoxFit.contain),
                  )),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping

              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
              print('${candidatesDatas[index].match}');
              print(orientation);
              if (orientation == CardSwipeOrientation.LEFT) {
                CoolAlert.show(
                  title: 'Refusé',
                  context: context,
                  type: CoolAlertType.error,
                  text:
                      "Le candidat ${candidatesDatas[index].nom} ${candidatesDatas[index].prenom} a été refusé.",
                  autoCloseDuration: Duration(seconds: 3),
                  onConfirmBtnTap: () {},
                );
                candidatesDatas[index].match = 'Refusé';
                airtableData.updateCandidate(candidatesDatas[index]);
              } else if (orientation == CardSwipeOrientation.RIGHT) {
                CoolAlert.show(
                  title: 'Admis',
                  context: context,
                  type: CoolAlertType.success,
                  text:
                      "Le candidat ${candidatesDatas[index].nom} ${candidatesDatas[index].prenom} a été admis.",
                  autoCloseDuration: Duration(seconds: 3),
                  onConfirmBtnTap: () {},
                );
                candidatesDatas[index].match = 'Admis';
                airtableData.updateCandidate(candidatesDatas[index]);
              }
            },
          ),
        ),
      ),
    );
  }
}

// *----------------------------------------------------------------
