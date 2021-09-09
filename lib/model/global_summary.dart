class GlobalSummary{
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;
  final int affectedCountry;

  GlobalSummary(
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered,
      this.affectedCountry,
      );

  factory GlobalSummary.fromjson(
      Map<String, dynamic> json ){
    return GlobalSummary(
        json["todayCases"],
    json["cases"],
    json["todayDeaths"],
    json["deaths"],
    json["todayRecovered"],
    json["recovered"],
      json["affectedCountries"],
    );
  }
}