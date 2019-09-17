import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AbrirMapa extends StatefulWidget {
  @override
  _AbrirMapaState createState() => _AbrirMapaState();
}

class _AbrirMapaState extends State<AbrirMapa> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _exibirMarcador( LatLng latLng){
//    Set<Marker> marcadoresLocal = {};
    Marker marcadoEscolhido = Marker(
      markerId: MarkerId("marcador-${latLng.latitude} - ${latLng.longitude}"),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: InfoWindow(
        title: "Marcado",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed
      ),
    );
    // Mostra apenas um marcador
//    marcadoresLocal.add(marcadoEscolhido);
    setState(() {
//      _marcadores = marcadoresLocal;
      _marcadores.add(marcadoEscolhido);

    });
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
          markers: _marcadores,
        ),
      ),
    );
  }
}
