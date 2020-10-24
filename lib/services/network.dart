import 'dart:convert';
import 'package:earthquake_app/model/quakeData_model.dart';
import 'package:http/http.dart';


// class Network {
//   final String url;
//   Network(this.url);

//   Future<EarthQuakeModel> getEarthQuakes() async {
//     final Response response = await get(Uri.encodeFull(url));
//     print(response.body);

//     if (response.statusCode == 200) {
//       return EarthQuakeModel.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to get Earth Quake data');
//     }
//   }
// }

