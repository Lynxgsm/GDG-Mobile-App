import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gdgapp/src/views/widgets/customAppBar.dart';
import 'package:gdgapp/src/views/widgets/customDrawer.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double zoom = 15.0;
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NavigationProvider>(context);
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: customAppBar(context, "${_provider.title}",
            isShowingTab: _provider.isShowingTab),
        body: Container(
            child: new FlutterMap(
                options: new MapOptions(
                    zoom: zoom, center: new LatLng(-18.8486735, 47.4803045)),
                layers: [
              new TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(markers: [
                new Marker(
                    point: new LatLng(-18.8486735, 47.4803045),
                    builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.place),
                            onPressed: () {
                              setState(() {
                                zoom = 18.0;
                                print(zoom);
                              });
                            },
                          ),
                        ))
              ])
            ])));
  }
}
