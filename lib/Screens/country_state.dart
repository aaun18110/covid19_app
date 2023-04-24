// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Model/world_state_model.dart';
import '../Services/state_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'countries_list.dart';

class CountryStateList extends StatefulWidget {
  const CountryStateList({super.key});

  @override
  State<CountryStateList> createState() => _CountryStateListState();
}

class _CountryStateListState extends State<CountryStateList>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .05),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            FutureBuilder(
                future: stateServices.fetchCountriesApiModel(),
                builder: (context, AsyncSnapshot<CountriesApiModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          size: 50.0,
                          color: Colors.white,
                          controller: _animationController,
                        ));
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .01),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const PageScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths":
                                  double.parse(snapshot.data!.deaths.toString())
                            },
                            chartType: ChartType.ring,
                            colorList: const [
                              Colors.blue,
                              Colors.green,
                              Colors.red,
                            ],
                            animationDuration: const Duration(seconds: 2),
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          Card(
                            child:
                                // FutureBuilder(
                                //     future: stateServices.fetchCountriesApiModel(),
                                //     builder: (context,
                                //         AsyncSnapshot<CountriesApiModel> snapshot) {
                                // if (!snapshot.hasData) {
                                //   return ListView.builder(
                                //       itemCount: 2,
                                //       itemBuilder: (context, index) {
                                //         return Shimmer.fromColors(
                                //           baseColor: Colors.grey.shade700,
                                //           highlightColor:
                                //               Colors.grey.shade100,
                                //           child: Container(
                                //             width: 80,
                                //             height: 10,
                                //             color: Colors.white,
                                //           ),
                                //         );
                                //       });
                                // } else {
                                Column(
                              children: [
                                ReuseablRow(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                ReuseablRow(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                ReuseablRow(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                ReuseablRow(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                ReuseablRow(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                ReuseablRow(
                                    title: "Today Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                ReuseablRow(
                                    title: "Today Recovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                            //}
                            //}),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          InkWell(
                              onTap: () {
                                print("tap");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CountriesList()));
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(14)),
                                child: const Center(
                                    child: Text(
                                  "Track Countries",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                )),
                              )),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class ReuseablRow extends StatelessWidget {
  String value, title;
  ReuseablRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(title),
              const Spacer(),
              Text(value),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
