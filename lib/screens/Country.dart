import 'package:covid19_tracker/model/country_summary.dart';
import 'package:covid19_tracker/screens/country_loading.dart';
import 'package:covid19_tracker/screens/country_stastics.dart';
import 'package:covid19_tracker/services/covid_services.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/model/countryModel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
CovidServices covidServices = CovidServices();

class Country extends StatefulWidget {
  const Country({Key key}) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  Future<List<CountryModel>> countrylist;

  final TextEditingController _typeaheadcontroller= TextEditingController();

  Future<List<CountrySummary>> summaryList;

  @override
  void initState() {
    super.initState();
    countrylist = covidServices.getCountryList();
    summaryList=covidServices.getCountrySummary("");
  this._typeaheadcontroller.text="";
  }
  List<String> _getSuggestion(List<CountryModel> list,String query){
    List<String> matches=List();
    for(var item in list){
      matches.add(item.country);
    }
    matches.retainWhere((element) => element.toLowerCase()
        .contains(query.toLowerCase()));

    return matches;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: countrylist,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CountryLoading(inputTextLoading: true);
            default:
              return !snapshot.hasData
                  ? Center(
                      child: Text("Error"),
                    )
                  : SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 6,
                            ),
                            child: Text(
                              "Type the Country Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TypeAheadFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                            controller:_typeaheadcontroller,
                            decoration: InputDecoration(
                              hintText: "Type Here",
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,

                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey,
                              contentPadding: EdgeInsets.all(10),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 24,right:16),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              )
                            ),

                          ),
                            suggestionsCallback: (pattern){
                                return _getSuggestion(snapshot.data,pattern);
                            },//responsible for view data in input field
                            itemBuilder: (context,suggestion){
                                return ListTile(
                                  title: Text(suggestion),
                                );
                            },
                            transitionBuilder: (context,suggestionBox,controller){
                               return suggestionBox;
                            },
                            onSuggestionSelected: (suggestion){
                                this._typeaheadcontroller.text=suggestion;
                                setState(() {
                                  summaryList=covidServices.getCountrySummary(
                                    snapshot.data.firstWhere((element)=>
                                    element.country==suggestion).slug);

                                });},
                          ),
                          SizedBox(height: 8,),
                          FutureBuilder(
                            future: summaryList,
                            builder: (context,snapshot){
                               if(snapshot.hasError){
                                return Center(
                                  child: Text("Error"),
                                );

                              }
                               switch(snapshot.connectionState){
                                 case ConnectionState.waiting:
                                   return CountryLoading(inputTextLoading: false,);
                                 default:
                                   return !snapshot.hasData
                                       ?Center(child: Text("Empty"),
                                   ):CountryStastics(summaryList: snapshot.data
                                   );
                               }
                            },
                          ),

                        ],
                      ),
                  );
          }
        });
  }
}
