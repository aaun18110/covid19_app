import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:covid19_app/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'country_details.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  var search = '';

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          shadowColor: Colors.white,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: AnimatedSearchBar(
            label: "Search Country name here....",
            controller: _searchController,
            labelStyle: const TextStyle(fontSize: 18),
            searchStyle: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            searchDecoration: const InputDecoration(
              hintText: "Search",
              alignLabelWithHint: true,
              fillColor: Colors.white,
              focusColor: Colors.white,
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
            onChanged: (val) {
              setState(() {
                search = val;
              });
            },
          )),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: stateServices.fetchCountriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: (contex, index) {
                            return ListTile(
                              leading: Container(
                                width: 89,
                                height: 50,
                                color: Colors.white,
                              ),
                              title: Container(
                                width: 89,
                                height: 10,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                width: 89,
                                height: 10,
                                color: Colors.white,
                              ),
                            );
                          }),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          search = snapshot.data![index]['country'];
                          if (_searchController.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryDetails(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              population: snapshot.data![index]
                                                  ['population'],
                                              todayCases: snapshot.data![index]
                                                  ['todayCases'],
                                              todayDeaths: snapshot.data![index]
                                                  ['todayDeaths'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                            )));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 40,
                                  width: 70,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  snapshot.data![index]['country'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ),
                            );
                          } else if (search
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase())) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryDetails(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              population: snapshot.data![index]
                                                  ['population'],
                                              todayCases: snapshot.data![index]
                                                  ['todayCases'],
                                              todayDeaths: snapshot.data![index]
                                                  ['todayDeaths'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                            )));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 40,
                                  width: 70,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  fit: BoxFit.cover,
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ]),
      ),
    );
  }
}
