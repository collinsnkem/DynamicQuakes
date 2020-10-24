import 'dart:async';
import 'dart:collection';

import 'package:earthquake_app/utils/colors.dart';
import 'package:earthquake_app/widgets/basic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EarthQuakeDetails extends StatefulWidget {
  final String title;
  final String date;
  final String status;
  final double magnitude;
  final double lat;
  final double lng;
  final String website;

  const EarthQuakeDetails(
      {Key key,
      this.title,
      this.date,
      this.status,
      this.magnitude,
      this.lat,
      this.website,
      this.lng})
      : super(key: key);
  @override
  _EarthQuakeDetailsState createState() => _EarthQuakeDetailsState();
}

class _EarthQuakeDetailsState extends State<EarthQuakeDetails> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: transparent,
          elevation: 0.0,
          centerTitle: true,
          iconTheme: IconThemeData(color: pryColor),
        ),
        body: Container(
          child: Column(
            children: [
              Divider(
                height: 5,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: bold, fontSize: 20, fontFamily: 'Jost'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer, size: 20, color: pryColor),
                  SizedBox(width: 5),
                  Text(widget.date,
                      style: TextStyle(
                          color: brown,
                          fontSize: 13,
                          fontWeight: bold,
                          fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                height: 5,
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Magnitude: ',
                        style: TextStyle(
                            color: secDark, fontWeight: bold, fontSize: 16)),
                    TextSpan(
                        text: '${widget.magnitude} MD',
                        style: TextStyle(
                            color: pryColor, fontWeight: bold, fontSize: 16))
                  ])),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'R. Status: ',
                        style: TextStyle(
                            color: secDark, fontWeight: bold, fontSize: 16)),
                    TextSpan(
                        text: '${widget.status.toUpperCase()}',
                        style: TextStyle(
                            color: pryColor, fontWeight: bold, fontSize: 16))
                  ])),
                  Text(''),
                ],
              ),

              // ! GOOGLE MAP STARTS
              Expanded(child: myGoogleMap(context)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Latitude: ',
                          style: TextStyle(
                              color: secDark, fontWeight: bold, fontSize: 13)),
                      TextSpan(
                          text: '${widget.lat.toStringAsFixed(4)}°N',
                          style: TextStyle(
                              color: pryColor, fontWeight: bold, fontSize: 13))
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Longitude: ',
                          style: TextStyle(
                              color: secDark, fontWeight: bold, fontSize: 13)),
                      TextSpan(
                          text: '${widget.lng.toStringAsFixed(4)}°W',
                          style: TextStyle(
                              color: pryColor, fontWeight: bold, fontSize: 13))
                    ])),
                    Text(''),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    _moreQuakeData();
                    debugPrint('More Data to Show');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: pryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'More Info on EarthQuake',
                      style: TextStyle(
                        fontFamily: 'Jost',
                          color: white, fontSize: 16, fontWeight: bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _moreQuakeData() async {
    String web = '${widget.website}';
    try {
      if (await canLaunch(web)) {
        await launch(web, forceWebView: true, enableJavaScript: true);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget myGoogleMap(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: GoogleMap(
          markers: markers,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setState(() {
              markers.add(Marker(
                markerId: MarkerId(widget.title),
                position: LatLng(
                  widget.lat,
                  widget.lng,
                ),
                infoWindow: InfoWindow(
                  title: "${widget.title}",
                  snippet: "Quake Magnitude: ${widget.magnitude}",
                  //onTap: _launchURL
                ),
              ));
            });
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 5),
        ),
      ),
    );
  }
}
