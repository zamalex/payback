import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/banches_response.dart';
import 'package:payback/model/partner_model.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/cart_screen.dart';
import 'package:payback/screens/partner_details_screen.dart';
import 'package:payback/screens/partners_screen.dart';
import 'package:payback/screens/scanner_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';

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
    WidgetsBinding.instance.addPostFrameCallback;

    Future.delayed(Duration.zero).then((value){
      Provider.of<HomeProvider>(context,listen: false).getVendors();
      Provider.of<HomeProvider>(context,listen: false).getBranches();
    });


    Future.delayed(Duration(seconds: 3)).then((value){
      buildDone=true;
    });

    //_addCustomMarkers();
  }

  void _addCustomMarkers() async {
    // Load PNG images from a network URL asynchronously
    final Uint8List logoBytes = await _getBytesFromNetwork('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAJ5hZ3dCotAy4FRZQT7THh5uPbYjeyQHexQ&usqp=CAU');

    _markers.add(
      Marker(
        markerId: MarkerId('marker1'),
        position: c,
        icon: BitmapDescriptor.fromBytes(logoBytes),
        onTap: () {
         // showStoreSheet(context);
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


  void showFiltersSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Consumer<HomeProvider>(
          builder:(context, value, child) => Container(
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: kBackgroundColor),
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(
                              'Partners categories',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Reset all',
                              style: TextStyle(fontSize: 18,color: Colors.red, fontWeight: FontWeight.bold),
                            ),

                          ],),
                          SizedBox(
                            height: 10,
                          ),

                        ]..addAll([
                          Expanded(
                            child: ListView.builder(

                              itemCount: value.mapCategories.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Checkbox(

                                      checkColor: Colors.white,
                                      fillColor: MaterialStatePropertyAll<Color>(kBlueColor),
                                      value: value.mapCategories[index].isMapSelected,
                                      shape: CircleBorder(),
                                      onChanged: (bool? v) {
                                        value.selectMapIndex(index);
                                      },
                                    ),
                                    Text(value.mapCategories[index].name??'',style: TextStyle(color: Colors.black),)
                                  ],
                                );
                              },
                            ),
                          ),

                        ])),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Container(
                      width: double.infinity,
                      child: CustomButton(
                          buttonText: 'Apply', buttonColor: kPurpleColor,onTap: (){value.getBranches();Navigator.pop(context);},)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  void showStoreSheet(BuildContext context,Branch? partner) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return partner==null?Container():Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: kBackgroundColor),
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(
                              'Partners details',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            TextButton.icon(onPressed: (){}, icon:Text('Go to partner'),label: Icon(Icons.navigation_outlined,color: kBlueColor,),)
                  
                  
                          ],),
                          SizedBox(
                            height: 10,
                          ),
                  
                        ]..addAll([
                  
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 56,height: 56,
                            decoration: BoxDecoration(image:DecorationImage(image: NetworkImage(partner.vendor?.image??'',),fit: BoxFit.cover),borderRadius: BorderRadius.circular(12),),
                          ),
                          title:  Text(
                            partner.name??'',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            partner.vendor?.description??'',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(height: 15,),
                         TextButton.icon(
                           style: ButtonStyle(padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero)),
                           onPressed: (){}, icon: Icon(Icons.pin_drop_outlined,color: Colors.black,), label:  Text(
                           partner.address??'',
                           style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold),
                         ),),
                          SizedBox(height: 15,),
                          Container(width: double.infinity,child: CustomButton(buttonColor: kPurpleColor,buttonText: 'View partner\'s shop',onTap: (){
                            Get.to(PartnerDetailsScreen(partner: partner.vendor!));
                          },),)
                  
                        ])),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  final locations = const [
    LatLng(37.42796133580664, -122.085749655962),
    LatLng(37.41796133580664, -122.085749655962),
    LatLng(37.43796133580664, -122.085749655962),
    LatLng(37.42796133580664, -122.095749655962),
  ];

  /*final images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrD9evOAc2Bj-rUWZ5I79EiHHGVNy7Wp3L9w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAJ5hZ3dCotAy4FRZQT7THh5uPbYjeyQHexQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1V3l9fyk4IDnrc0TewVmAPM2C-d2TlhiyZQ&usqp=CAU',
    'https://static.vecteezy.com/system/resources/previews/017/396/814/non_2x/netflix-mobile-application-logo-free-png.png'
  ];*/
  Map<String, double> getRandomLatLong() {
    // Define the range for latitude and longitude
    const double minLat = -90;
    const double maxLat = 90;
    const double minLong = -180;
    const double maxLong = 180;

    // Generate random latitude and longitude
    double latitude = Random().nextDouble() * (maxLat - minLat) + minLat;
    double longitude = Random().nextDouble() * (maxLong - minLong) + minLong;

    // Round latitude and longitude to 6 decimal places
    latitude = double.parse(latitude.toStringAsFixed(6));
    longitude = double.parse(longitude.toStringAsFixed(6));

    return {'latitude': latitude, 'longitude': longitude};
  }
  bool buildDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              showFiltersSheet(context);
            },
            child: Row(children: [
              Text('Filters',style: TextStyle(color: kPurpleColor),),
              Icon(Icons.filter_alt_outlined,color: kPurpleColor,)
            ],),
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('In-stores',style: TextStyle(fontWeight: FontWeight.bold),),
        leadingWidth: 120,
        leading: TextButton.icon(onPressed: (){
          Get.to(PartnersScreen());
        }, icon: Icon(Icons.list,color: kPurpleColor,), label: Text('Show list',style: TextStyle(color: kPurpleColor),)),
      ),
      body: Consumer<HomeProvider>(
        builder:(context, value, child){
          return value.branches.isEmpty?Container(child: Center(child: Text('No available branches'),),):CustomGoogleMapMarkerBuilder(
              screenshotDelay: Duration(seconds: buildDone?0:3),
              builder:(p0, markers) => markers==null? Center(child: CircularProgressIndicator()):GoogleMap(
                markers: markers,
                mapType: MapType.normal,
                initialCameraPosition:  CameraPosition(
                  target: LatLng(value.branches.last.locationLat??getRandomLatLong()['latitude']!, value.branches.last.locationLng??getRandomLatLong()['longitude']!),
                  zoom: 11,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);

                },
              ), customMarkers: value.branches.isEmpty?[]:List.generate(value.branches.length, (index) => MarkerData(
              marker: Marker(  markerId:  MarkerId('${value.branches[index].locationLat??getRandomLatLong()['latitude']!}'), position: LatLng(value.branches[index].locationLat??getRandomLatLong()['latitude']!,value.branches[index].locationLng??getRandomLatLong()['longitude']!),onTap: (){

                  showStoreSheet(context,value.branches[index]);




              }),
              child: _customMarker(/*value.branches[index].image??*/value.branches[index].vendor!.image!, Colors.white)))
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: kPurpleColor,
        child: Icon(Icons.qr_code,color: Colors.white,),
        onPressed: (){



          Get.to(ScannerScreen());
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
   // final GoogleMapController controller = await _controller.future;
   // await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


  _customMarker(String symbol, Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.location_pin,
          color: color,
          size: 100,
        ),
        Positioned(
          top: 5,
          height: 60,
          width: 60,
       //   left: 25,
        //  top: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: CachedNetworkImage(

               imageUrl: symbol,
              width: 60,
              height: 60,

              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset('assets/images/payback_logo.png',color: Colors.blue,),

            ),
          ),
        )
      ],
    );
  }
}