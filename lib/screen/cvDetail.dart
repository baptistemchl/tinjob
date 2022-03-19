import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tinjob/model/airtable_data_candidate.dart';

class RealisationScreen extends StatelessWidget {
  final AirtableDataCandidate candidate;
  RealisationScreen({required this.candidate});
  List<String> imgList = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    for (var imgs in candidate.realisations) {
      imgList.add(imgs);
    }
    return Scaffold(
        appBar: AppBar(
            title: const Text('Aperçu de mes réalisations'),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(255, 48, 118, 146)),
        backgroundColor: const Color.fromRGBO(246, 243, 240, 1),
        body: Builder(
          builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return Column(children: [
              Expanded(
                child: CarouselSlider(
                  items: imgList
                      .map((item) => Container(
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
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(item: item)));
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(item,
                                            fit: BoxFit.cover, width: 1000.0),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color.fromARGB(
                                                      255, 48, 118, 146),
                                                  const Color.fromARGB(
                                                      0, 0, 0, 0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: Text(
                                              'Réalisation n°${imgList.indexOf(item) + 1}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ))
                      .toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                      height: height,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      autoPlayCurve: Curves.fastOutSlowIn),
                ),
              ),
            ]);
          },
        ));
  }
}

class DetailScreen extends StatelessWidget {
  final String item;
  DetailScreen({required this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 48, 118, 146)),
            child: Center(
              child: Hero(
                tag: '',
                child: Image.network(
                  item,
                ),
              ),
            )),
      ),
    );
  }
}
