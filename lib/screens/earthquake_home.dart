import 'dart:async';
import 'dart:convert';

import 'package:earthquake_app/model/quakeData_model.dart';
import 'package:earthquake_app/screens/earthquake_details.dart';
import 'package:earthquake_app/services/network.dart';
import 'package:earthquake_app/utils/colors.dart';
import 'package:earthquake_app/utils/formats.dart';
import 'package:earthquake_app/widgets/basic_widgets.dart';
import 'package:earthquake_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';



class EarthQuakeHome extends StatefulWidget {
  @override
  _EarthQuakeHomeState createState() => _EarthQuakeHomeState();
}

class _EarthQuakeHomeState extends State<EarthQuakeHome> {
  Future<EarthQuakeModel> quakeData;

  var _connectivityStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  

  @override
  void initState() {
    super.initState();
    // Network network = Network(
    //     "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_week.geojson");
    quakeData = getEarthQuakes();

    connectivity = Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityStatus = result.toString();
      print(_connectivityStatus);
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
          getEarthQuakes();
      }
      return result;
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // final String url;
  // Network(this.url);

  Future<EarthQuakeModel> getEarthQuakes() async {
    final Response response = await get(Uri.encodeFull('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_week.geojson'));
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        
      });
      return EarthQuakeModel.fromJson(json.decode(response.body));
      
    } else {
      throw Exception('Failed to get Earth Quake data');
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: new IconThemeData(color: pryColor),
      ),
      //! THE APPLICATION BODY STARTS HERE
      body: FutureBuilder(
          future: quakeData,
          builder:
              (BuildContext context, AsyncSnapshot<EarthQuakeModel> snapshot) {
            var quakes = snapshot.data;
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                        image: AssetImage('images/earth.jpg'))),
                                //child: Image.asset('images/earth.jpg'),
                              ),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    color: secLight,
                                    child: Text(
                                      quakes.metadata.title,
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Today's Date: ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: secDark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        DateUtil.formatDate(DateTime.now()),
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: pryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            color: secDark,
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: quakes.features.length,
                        itemBuilder: (_, index) {
                          var place = quakes.features[index].properties.place;
                          var time = quakes.features[index].properties.time;
                          var status = quakes.features[index].properties.status;
                          var magnitude = quakes.features[index].properties.mag;
                          var lat =
                              quakes.features[index].geometry.coordinates[1];
                          var lng =
                              quakes.features[index].geometry.coordinates[0];
                          var web = quakes.features[index].properties.url;

                          var date = DateUtil.formatDate(
                              DateTime.fromMillisecondsSinceEpoch(time * 1000));

                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EarthQuakeDetails(
                                  title: place,
                                  magnitude: magnitude,
                                  status: status,
                                  date: date,
                                  lat: lat,
                                  lng: lng,
                                  website: web,
                                );
                              }));
                            },
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: pryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${index + 1}",
                                    style: TextStyle(color: white, fontFamily: 'Jost', fontSize: 15),
                                  )),
                                ),
                                title: Text(
                                  place,
                                  style: TextStyle(fontWeight: bold, fontFamily: 'Jost'),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(DateUtil.formatDate(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            time * 1000))),
                                    Text(
                                      status.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: bold,
                                          color: secDark,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Center(
                  child: SizedBox(
                height: 70,
                width: 70,
                child: CircularProgressIndicator(
                  backgroundColor: pryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(secDark),
                  strokeWidth: 10,
                ),
              ));
            }
          }),

      drawer: Drawer(
        child: MainDrawer(),
      ),
    );
  }
}
