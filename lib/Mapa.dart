import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AbrirMapa extends StatefulWidget {
  @override
  _AbrirMapaState createState() => _AbrirMapaState();
}

class _AbrirMapaState extends State<AbrirMapa> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};
  CameraPosition _cameraPosition =  CameraPosition(
  target: LatLng(-23.562436, -46.655005),
  zoom: 18
  );

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _exibirMarcador( LatLng latLng) async {
    Set<Marker> marcadoresLocal = {};
    List<Placemark> listaEnderecos = await Geolocator().placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if(listaEnderecos != null && listaEnderecos.length>0){
      Placemark endereco = listaEnderecos[0];
      String rua = endereco.thoroughfare;
      Marker marcadoEscolhido = Marker(
        markerId: MarkerId("marcador-${latLng.latitude} - ${latLng.longitude}"),
        position: LatLng(latLng.latitude, latLng.longitude),
        infoWindow: InfoWindow(
          title: rua,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed
        ),
      );
      // Mostra apenas um marcador
    marcadoresLocal.add(marcadoEscolhido);
      setState(() {
      _marcadores = marcadoresLocal;
//        _marcadores.add(marcadoEscolhido);

      });
    }
  }

  _movimentarCamera()async{
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          _cameraPosition
        )
    );
  }

  _adicionarListenerLocalizacao(){
    var geolocato = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high);
    geolocato.getPositionStream(locationOptions).listen((Position postion){
      setState(() {
        _cameraPosition = CameraPosition(
          target: LatLng(postion.latitude, postion.longitude),
          zoom: 18
        );
        _movimentarCamera();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adicionarListenerLocalizacao();
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
          initialCameraPosition: _cameraPosition,
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
          markers: _marcadores,
        ),
      ),
    );
  }
}
