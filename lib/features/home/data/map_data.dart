import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';


class DominantParty{
  MapData data;
  int counter;

  DominantParty({this.data , this.counter = 0});
}

class MapData extends Equatable{
  String state;
  String party;
  Color color;
  LatLng point;

  MapData({this.state, this.party, this.color, this.point});

  @override
  List<Object> get props => [
    state, party, color, point
  ];
}

class PartyData{
  int independent;
  int republic;
  int democrat;
  int other;
  int total;

  PartyData({this.democrat, this.independent, this.other, this.republic});

   void calculatePercent(int total){
    independent = ((independent / total) * 100).toInt();
    republic = ((republic / total) * 100).toInt();
    democrat = ((democrat / total) * 100).toInt();
    other = ((other / total) * 100).toInt();

   }

}


List<MapData> listMapData;

// List<MapData> listMapData = List<MapData>.generate(
//   states.length,
//   (index) => MapData(
//     color: Colors.orange,
//     party: null,
//     state: states[index],
//     point : statesLatlng[index]
//   ),
// );

List<LatLng> statesLatlng = [
  LatLng(32.3182, -86.9023),
  LatLng(64.2008, -149.4937),
  LatLng(34.0489, -111.0937),
  LatLng(35.2010, -91.8318),
  LatLng(36.7783, -119.4179),
  LatLng(39.5501, -105.7821),
  LatLng(41.6032, -73.0877),
  LatLng(38.9108, -75.5277),
  LatLng(27.6648, -81.5158),
  LatLng(32.1656, -82.9001),
  LatLng(19.8968, -155.5828),
  LatLng(44.0682, -114.7420),
  LatLng(40.6331, -89.3985),
  LatLng(40.2672, -86.1349),
  LatLng(41.8780, -93.0977),
  LatLng(39.0119, -98.4842),
  LatLng(37.8393, -84.2700),
  LatLng(30.9843, -91.9623),
  LatLng(45.2538, -69.4455),
  LatLng(39.0458, -76.6413),
  LatLng(42.4072, -71.3824),
  LatLng(44.3148, -85.6024),
  LatLng(46.7296, -94.6859),
  LatLng(32.3547, -89.3985),
  LatLng(37.9643, -91.8318),
  LatLng(46.8797, -110.3626),
  LatLng(41.4925, -99.9018),
  LatLng(38.8026, -116.4194),
  LatLng(43.1939, -71.5724),
  LatLng(40.0583, -74.4057),
  LatLng(34.5199, -105.8701),
  LatLng(40.7128, -74.0060),
  LatLng(35.7596, -79.0193),
  LatLng(47.5515, -101.0020),
  LatLng(40.4173, -82.9071),
  LatLng(35.0078, -97.0929),
  LatLng(43.8041, -120.5542),
  LatLng(41.2033, -77.1945),
  LatLng(41.5801, -71.4774),
  LatLng(33.8361, -81.1637),
  LatLng(43.9695, -99.9018),
  LatLng(35.5175, -86.5804),
  LatLng(31.9686, -99.9018),
  LatLng(39.3210, -111.0937),
  LatLng(44.5588, -72.5778),
  LatLng(37.4316, -78.6569),
  LatLng(47.7511, -120.7401),
  LatLng(38.5976, -80.4549),
  LatLng(43.7844, -88.7879),
  LatLng(43.0760, -107.2903),
 
];

List<String> states = [
  "Alabama",
  "Alaska",
  "Arizona",
  "Arkansas",
  "California",
  "Colorado",
  "Connecticut",
  "Delaware",
  "Florida",
  "Georgia",
  "Hawaii",
  "Idaho",
  "Illinois",
  "Indiana",
  "Iowa",
  "Kansas",
  "Kentucky",
  "Louisiana",
  "Maine",
  "Maryland",
  "Massachusetts",
  "Michigan",
  "Minnesota",
  "Mississippi",
  "Missouri",
  "Montana",
  "Nebraska",
  "Nevada",
  "New Hampshire",
  "New Jersey",
  "New Mexico",
  "New York",
  "North Carolina",
  "North Dakota",
  "Ohio",
  "Oklahoma",
  "Oregon",
  "Pennsylvania",
  "Rhode Island",
  "South Carolina",
  "South Dakota",
  "Tennessee",
  "Texas",
  "Utah",
  "Vermont",
  "Virginia",
  "Washington",
  "West Virginia",
  "Wisconsin",
  "Wyoming"
];
