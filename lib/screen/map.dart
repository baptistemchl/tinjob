import 'package:animate_do/animate_do.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:tinjob/model/airtable_data_candidate.dart';
import 'package:tinjob/model/airtable_data_company.dart';
import 'package:tinjob/screen/candidateDetail.dart';
import 'package:tinjob/service/airtable_data_candidate_http.dart';
import 'package:tinjob/service/airtable_data_company_http.dart';
import 'package:tinjob/widgets/widget_alert_description.dart';
import 'package:tinjob/widgets/widget_drawer.dart';
import 'package:shape_of_view/shape_of_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final AirtableDataCandidateHttp airtableDataCandidate =
      AirtableDataCandidateHttp();

  final AirtableDataCompanyHttp airtableDataCompany = AirtableDataCompanyHttp();
  var company;
  List<Marker> markers = [];

  final PopupController _popupController = PopupController();

  setMarkers() async {
    company = await airtableDataCompany.getCompany();
    setState(() {
      markers.add(Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 50,
        width: 50,
        point: latLng.LatLng(company.lat, company.long),
        builder: (ctx) => Bounce(
            child: ShapeOfView(
                shape: BubbleShape(
                    position: BubblePosition.Bottom,
                    arrowPositionPercent: 0.5,
                    borderRadius: 12,
                    arrowHeight: 20,
                    arrowWidth: 20),
                child: Container(
                    child: popupdescription(
                  context,
                  company.nom,
                  company.logo,
                  company.description,
                )))),
      ));
    });

    var candidate = await airtableDataCandidate.getCandidate();
    for (var point in candidate) {
      setState(() {
        markers.add(
          Marker(
              anchorPos: AnchorPos.align(AnchorAlign.center),
              height: 50,
              width: 50,
              point: latLng.LatLng(point.lat, point.long),
              builder: (ctx) => Bounce(
                  child: ShapeOfView(
                      shape: BubbleShape(
                          position: BubblePosition.Bottom,
                          arrowPositionPercent: 0.5,
                          borderRadius: 12,
                          arrowHeight: 20,
                          arrowWidth: 20),
                      child: popupdescription(
                          context,
                          point.nom + ' ' + point.prenom,
                          point.photo,
                          point.statut)))),
        );
        markers = List.from(markers);
      });
    }
  }

  @override
  void initState() {
    setMarkers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Localisation des candidats'),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(255, 48, 118, 146)),
        drawer: drawer(context),
        body: FutureBuilder(
          future: airtableDataCompany.getCompany(),
          builder: (BuildContext context,
              AsyncSnapshot<AirtableDataCompany> snapshot) {
            if (snapshot.hasData) {
              AirtableDataCompany? value = snapshot.data;
              return FlutterMap(
                options: MapOptions(
                  center: latLng.LatLng(value!.lat, value.long),
                  zoom: 2,
                  maxZoom: 15,
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                  onTap: (_, __) => _popupController
                      .hideAllPopups(), // Hide popup when the map is tapped.
                ),
                children: <Widget>[
                  TileLayerWidget(
                    options: TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                  ),
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      spiderfyCircleRadius: 80,
                      spiderfySpiralDistanceMultiplier: 2,
                      circleSpiralSwitchover: 12,
                      maxClusterRadius: 120,
                      rotate: true,
                      size: const Size(40, 40),
                      anchor: AnchorPos.align(AnchorAlign.center),
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                        maxZoom: 15,
                      ),
                      markers: markers,
                      polygonOptions: const PolygonOptions(
                          borderColor: Colors.blueAccent,
                          color: Colors.black12,
                          borderStrokeWidth: 3),
                      builder: (context, markers) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
