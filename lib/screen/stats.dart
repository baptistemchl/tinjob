import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tinjob/model/airtable_data_candidate.dart';
import 'package:tinjob/service/airtable_data_candidate_http.dart';
import 'package:tinjob/widgets/widget_drawer.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class ChartData {
  ChartData(this.x, this.y);
  String x;
  int y;
}

class _StatsScreenState extends State<StatsScreen> {
  final AirtableDataCandidateHttp airtableDataCandidate =
      AirtableDataCandidateHttp();
  int admis = 0;
  int refus = 0;
  int waiting = 0;
  int total = 0;
  setAdmis() async {
    var countadmis = await airtableDataCandidate.getCandidateAdmis();
    var countrefus = await airtableDataCandidate.getCandidateRefuse();
    var countattente = await airtableDataCandidate.getCandidateWaiting();
    setState(() {
      admis = countadmis.length;
      refus = countrefus.length;
      waiting = countattente.length;
      total = admis + refus + waiting;
    });
  }

  @override
  void initState() {
    setAdmis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Admis', admis),
      ChartData('Refusés', refus),
      ChartData('En attente', waiting),
    ];
    return Scaffold(
        appBar: AppBar(
            title: const Text('Statistiques'),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(255, 48, 118, 146)),
        body: Container(
            child: Center(
                child: SfCircularChart(
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Container(
                              child: Text('Total candidats ' + '${total}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      fontSize: 15))))
                    ],
                    enableMultiSelection: true,
                    legend: Legend(isVisible: true),
                    title: ChartTitle(text: 'Vos statistiques'),
                    series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                          dataLabelSettings: const DataLabelSettings(
                              // Renders the data label
                              isVisible: true),
                          explode: true,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ]))));
  }
}
