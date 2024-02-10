import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:payback/helpers/colors.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final LatLng c = LatLng(37.7749, -122.4194); // San Francisco coordinates

  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _addCustomMarkers();
  }

  void _addCustomMarkers() async {
    // Load PNG images from a network URL asynchronously
    final Uint8List logoBytes = await _getBytesFromNetwork('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAJ5hZ3dCotAy4FRZQT7THh5uPbYjeyQHexQ&usqp=CAU');

    _markers.add(
      Marker(
        markerId: MarkerId('marker1'),
        position: c,
       // icon: BitmapDescriptor.fromBytes(logoBytes),
        onTap: () {
          // Handle marker tap
        },
      ),
    );
    setState(() {

    });

    // Add more markers as needed
  }

  Future<Uint8List> _getBytesFromNetwork(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    return Uint8List.fromList(response.bodyBytes);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 14.4746,
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(children: [
            Text('Filters',style: TextStyle(color: kPurpleColor),),
            Icon(Icons.filter_alt_outlined,color: kPurpleColor,)
          ],)
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('In-stores',style: TextStyle(fontWeight: FontWeight.bold),),
        leadingWidth: 120,
        leading: TextButton.icon(onPressed: (){}, icon: Icon(Icons.list,color: kPurpleColor,), label: Text('Show list',style: TextStyle(color: kPurpleColor),)),
      ),
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: kPurpleColor,
        child: Icon(Icons.qr_code,color: Colors.white,),
        onPressed: _goToTheLake,
      ),
    );
  }

  Future<void> _goToTheLake() async {
   // final GoogleMapController controller = await _controller.future;
   // await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}