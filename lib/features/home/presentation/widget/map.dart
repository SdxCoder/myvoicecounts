import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(51.5, -0.09),
        builder: (ctx) => Container(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Container(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Container(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Container(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight : Radius.circular(20)
        )),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: 5.0,
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
      ),
    );
  }
}
