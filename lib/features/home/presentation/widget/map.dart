import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:myvoicecounts/features/home/data/map_data.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

    print("Markers : ${markers.length}");
    return ResponsiveBuilder(
      builder : (context, sizingInfo) =>
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    interactive: false,
                   // maxZoom: 5,
                   // minZoom: 3.5,
                    center: (sizingInfo.screenSize.width < 600) ? LatLng(52.00, -107.00) : (sizingInfo.screenSize.width < 1000) ? LatLng(50.00, -105.00) : LatLng(52.00, -102.00),
                    zoom: (sizingInfo.screenSize.width < 480) ? 1.9 : (sizingInfo.screenSize.width < 600) ? 2.3 : (sizingInfo.screenSize.width < 800) ? 2.8 : (sizingInfo.screenSize.width < 1024) ? 3.0 : 3.2
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
