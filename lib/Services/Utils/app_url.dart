class AppUrl {
  //Hit to API
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  //fetch data for API
  static const String worldStateApi = '${baseUrl}all';
  static const String countriesList = '${baseUrl}countries';
}
