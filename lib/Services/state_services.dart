import 'dart:convert';
import 'package:covid19_app/Model/world_state_model.dart';
import 'package:http/http.dart' as http;
import 'Utils/app_url.dart';

class StateServices {
  Future<CountriesApiModel> fetchCountriesApiModel() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return CountriesApiModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
