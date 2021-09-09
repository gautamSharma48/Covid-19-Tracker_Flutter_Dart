import 'dart:convert';
import 'package:covid19_tracker/model/countryModel.dart';
import 'package:covid19_tracker/model/country_summary.dart';
import 'package:covid19_tracker/model/global_summary.dart';

import 'package:covid19_tracker/model/global_summary.dart';
import 'package:http/http.dart' as http;


class CovidServices {
  Future <GlobalSummary> getGlobalSummary()
  async {
    try {
       var uriResponse =
      await http.get(Uri.parse(
          "https://corona.lmao.ninja/v2/all"
      ));
      print("-*-*-*result uriResponse-*-*-${uriResponse.body}");
      if (uriResponse.statusCode != 200) {
        throw Exception();
      }
      else
        print("uriResponseStatuscode${uriResponse.statusCode}");

       GlobalSummary summary = GlobalSummary.fromjson(
          json.decode(uriResponse.body));
      return summary;
    } catch(e){
      print(e);
    }
  }
  Future<List<CountrySummary>> getCountrySummary(String slug) async{
    try {
      var uriResponse =
      await http.get(Uri.parse(
          "https://api.covid19api.com/total/dayone/country/" + slug
      ));
      print("*****result uriResponse*****${uriResponse.body}");
      if (uriResponse.statusCode != 200) {
        throw Exception();
      }
      List<CountrySummary> summaryList =
      (json.decode(uriResponse.body) as List).map((item)=>
          CountrySummary.fromJson(item)).toList();
      return summaryList;
    }
    catch(e){
      print(e);
    }
  }
  Future<List<CountryModel>> getCountryList() async{
    try {
      var uriResponse =
      await http.get(Uri.parse(
          "https://api.covid19api.com/countries"
      ));
      print("----result uriResponse---${uriResponse.body}");
      if (uriResponse.statusCode != 200) {
        throw Exception();
      }
      List<CountryModel> countries =
      (json.decode(uriResponse.body) as List).map(
              (item)=>
      CountryModel.fromJson(item)).toList();
       return countries;

    }
    catch(e){
      print(e);
    }
  }

}
