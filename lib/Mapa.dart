import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AbrirMapa extends StatefulWidget {
  @override
  _AbrirMapaState createState() => _AbrirMapaState();
}

class _AbrirMapaState extends State<AbrirMapa> {
  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _exibirMarcador( LatLng latLng){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas*"),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(-23.562436, -46.655005),
              zoom: 18
          ),
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
        ),
      ),
    );
  }
}
