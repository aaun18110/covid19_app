// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'country_state.dart';

class CountryDetails extends StatefulWidget {
  final String image;
  final String name;
  final int todayCases;
  final int todayDeaths;
  final int todayRecovered;
  final int active;
  final int critical;
  final int test;
  final int population;
  const CountryDetails({
    Key? key,
    required this.image,
    required this.name,
    required this.todayCases,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.test,
    required this.population,
  }) : super(key: key);

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .067),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                          ReuseablRow(
                              title: "Population",
                              value: widget.population.toString()),
                          ReuseablRow(
                              title: "Name", value: widget.name.toString()),
                          ReuseablRow(
                              title: "Today Cases",
                              value: widget.todayCases.toString()),
                          ReuseablRow(
                              title: "Today Deaths",
                              value: widget.todayCases.toString()),
                          ReuseablRow(
                              title: "Today Recovered",
                              value: widget.todayRecovered.toString()),
                          ReuseablRow(
                              title: "Today Deaths",
                              value: widget.todayDeaths.toString()),
                          ReuseablRow(
                              title: "Test", value: widget.test.toString()),
                          ReuseablRow(
                              title: "Critical",
                              value: widget.critical.toString())
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      widget.image,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
