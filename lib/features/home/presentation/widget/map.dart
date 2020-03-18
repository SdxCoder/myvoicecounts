import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:myvoicecounts/features/home/data/map_data.dart';

class MapView extends StatelessWidget {

  final List<MapData> dataList;

  const MapView({Key key, this.dataList}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      for(var data in dataList) ...
     
      [
      Marker(
        width: 15.0,
        height: 15.0,
        point: data.point,
        builder: (ctx) => Container(
          child: Container(
            decoration: BoxDecoration(
                color: data.color, borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
      ]
     
    ];

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: FlutterMap(

              options: MapOptions(
                interactive: true,
                maxZoom: 5,
                minZoom: 3.5,
                rotation: 20,
                center: LatLng(41.00, -100.00),
                zoom: 3.5,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  // For example purposes. It is recommended to use
                  // TileProvider with a caching and retry strategy, like
                  // NetworkTileProvider or CachedNetworkTileProvider
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
                MarkerLayerOptions(markers: markers)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
