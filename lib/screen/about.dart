// ignore_for_file: unnecessary_const

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tinjob/screen/home.dart';
import 'package:tinjob/widgets/widget_drawer.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AboutScreen()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Container(
        child: Scaffold(
            appBar: AppBar(
                title: const Text('A propos'),
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Color.fromARGB(255, 48, 118, 146)),
            backgroundColor: const Color.fromRGBO(246, 243, 240, 1),
            body: IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.white,

              pages: [
                PageViewModel(
                  title: "A propos...",
                  body: "TinJob est une application absolument unique.",
                  image: _buildImage('IMG_intro1.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "Un concept nouveau...",
                  body:
                      "Il y a de nombreuses applications de recrutement, mais TinJob se démarque par de nombreux points.",
                  image: _buildImage('IMG_intro2.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "De recrutement ?",
                  body:
                      "Ayant moi même cherché du travail pendant quelque temps, certaines choses m'ont agacées.",
                  image: _buildImage('IMG_intro3.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "Des contraintes connues et reconnues ?",
                  body:
                      "Le jugement au faciès, les piles de CV qui s'amassent, comment se démarquer..",
                  image: _buildImage('IMG_intro1.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  useScrollView: true,
                  title: "Ma solution, votre solution !",
                  body:
                      "Terminé les 100aines de CV envoyés, terminé les embuches des entretiens. Avec TinJob, tout est plus simple, tout est plus rapide. Le but est de favoriser les échanges entre le recruteur et le candidat. Grace à un système à la Tinder, vous pouvez rapidement voir le profil que vous souhaitez. Puis le contacter ! Une map est même disponible afin d'apercevoir les candidats à proximité, un gain de temps non négligeable.",
                  decoration: pageDecoration,
                ),
              ],
              onDone: () => Navigator.pushNamed(context, '/'),
              //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
              showSkipButton: false,
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: true,
              //rtl: true, // Display as right-to-left
              back: const Icon(Icons.arrow_back),
              skip: const Text('Passer',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              next: const Icon(Icons.arrow_forward),
              done: const Text('Terminé',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              controlsPadding: kIsWeb
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              dotsContainerDecorator: const ShapeDecoration(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            )));
  }
}
