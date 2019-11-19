import 'package:flutter/material.dart';
//import 'package:amap_base/amap_base.dart';

//高德地图
class MapPage extends StatelessWidget {

  MapPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('高德地图'),),
//      body: AMapView(
//        onAMapViewCreated: (controller) {
//          print(controller);
//        },
//        amapOptions: AMapOptions(
//          compassEnabled: false,
//          zoomControlsEnabled: true,
//          logoPosition: LOGO_POSITION_BOTTOM_CENTER,
//          camera: CameraPosition(
//            target: LatLng(41.851827, 112.801637),
//            zoom: 4,
//          ),
//        ),
//      )
    body: Text('hhh '),
    );
  }

}
