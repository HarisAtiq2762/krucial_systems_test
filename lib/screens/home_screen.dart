import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'as gm;
import 'package:http/http.dart' as http;
import 'package:krucial_systems/models/Store.dart';
import 'package:krucial_systems/provider/home_scroll_animation.dart';
import 'package:krucial_systems/widgets/home_screen_card.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<Position> getCurrentLocation()async{
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List <Placemark>pms = await placemarkFromCoordinates(p.latitude, p.longitude);
    placeMarks = pms.first;
    return p;
  }

  void getNearby(double lat,double long)async{
    var headers = {
      'content-type': 'application/json',
      'x-rapidapi-host': 'nearby-amenities-and-point-of-interest.p.rapidapi.com',
      'x-rapidapi-key': 'dea41dd414msh6cdb30dfa014e9ap12e2ccjsnb99bbc796c0c'
    };
    var request = http.Request('POST', Uri.parse('https://nearby-amenities-and-point-of-interest.p.rapidapi.com/nearby'));
    request.body = json.encode({
      'amenity': 'cafe', 'lat': lat, 'limit': 1000, 'lon': long
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(await response.stream.bytesToString());
  }

  Placemark placeMarks;
  List<Store> _stores = [
    Store(
        img: 'assets/images/sm.png',
        name: 'Kings Supermarket',
        category: 'Food & Drink',
        rating: '5.0',
        address: '23 Kings Street, Sydney'
    ),
    Store(
        img: 'assets/images/coffee.png',
        name: 'Real Drink Bottle Shop',
        category: 'Food & Drink',
        rating: '4.0',
        address: '23 Kings Street, Sydney'
    ),
    Store(
        img: 'assets/images/sm.png',
        name: 'Kings Supermarket',
        category: 'Food & Drink',
        rating: '5.0',
        address: '23 Kings Street, Sydney'
    ),
    Store(
        img: 'assets/images/coffee.png',
        name: 'Real Drink Bottle Shop',
        category: 'Food & Drink',
        rating: '4.0',
        address: '23 Kings Street, Sydney'
    ),
    Store(
        img: 'assets/images/sm.png',
        name: 'Kings Supermarket',
        category: 'Food & Drink',
        rating: '5.0',
        address: '23 Kings Street, Sydney'
    ),
    Store(
        img: 'assets/images/coffee.png',
        name: 'Real Drink Bottle Shop',
        category: 'Food & Drink',
        rating: '4.0',
        address: '23 Kings Street, Sydney'
    ),
    Store(
        img: 'assets/images/sm.png',
        name: 'Kings Supermarket',
        category: 'Food & Drink',
        rating: '5.0',
        address: '23 Kings Street, Sydney'
    ),
    Store(
        img: 'assets/images/coffee.png',
        name: 'Real Drink Bottle Shop',
        category: 'Food & Drink',
        rating: '4.0',
        address: '23 Kings Street, Sydney'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              FutureBuilder(
                future: getCurrentLocation(),
                builder: (context,snap){
                  if(snap.connectionState==ConnectionState.done){
                    Position p = snap.data;
                    getNearby(p.latitude,p.longitude);
                    return Stack(
                      children: [
                        GoogleMap(
                            markers: Set<Marker>.of([
                              Marker(
                                  markerId: MarkerId('I am here'),
                                  position: gm.LatLng(p.latitude,p.longitude),
                                  infoWindow: InfoWindow(
                                      title: 'Hey, I am here'
                                  )
                              )
                            ]),
                            myLocationButtonEnabled: true,
                            mapType: MapType.normal,
                            zoomControlsEnabled: true,
                            initialCameraPosition: CameraPosition(
                                zoom: 15,
                                target: gm.LatLng(
                                    p.latitude,p.longitude
                                ))
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(icon: Icon(Icons.arrow_back,size: 25.0,color: Colors.black,), onPressed: (){Navigator.pop(context);}),
                                    Column(
                                      children: [
                                        Text('Deliver to',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                        Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.mapMarker,color: Colors.red.shade300,size: 12,),
                                            Text(' '+placeMarks.street,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    FaIcon(FontAwesomeIcons.filter,size: 15,)
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: MediaQuery.of(context).size.height*0.055,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                          hintStyle: TextStyle(color: Colors.black,fontSize: 15),
                                          prefixIcon: FaIcon(FontAwesomeIcons.search,color: Colors.black,size: 20,)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    return Container();
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<HomeScrollAnimation>(
                  builder: (context,scroll,child){
                    return AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: MediaQuery.of(context).size.height*scroll.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.4),blurRadius: 20)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                scroll.changeHeight();
                              },
                              child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Explore Stores',style: TextStyle(color: Colors.orange.shade300,fontSize: 35,fontWeight: FontWeight.w900),),
                                      Text('Near You',style: TextStyle(color: Colors.orange.shade300,fontSize: 35,fontWeight: FontWeight.w900),),
                                    ],
                                  ))),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              itemCount: _stores.length,
                              itemBuilder: (context,index){
                                return HomeScreenCard(store: _stores[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
