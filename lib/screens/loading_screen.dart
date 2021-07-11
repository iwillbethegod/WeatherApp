import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_map_weather_api/open_map_weather_api.dart';
import '../services/networking.dart';
import '../screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/location.dart';

OpenWeather openWeather = OpenWeather('f875808edaf93c2e98f0b1908ed7e8c1');

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocAndData lnd=LocAndData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    process();
  }
  void process() async{
    Position pos=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    Weather wea=await openWeather.currentWeatherByLocation(latitude: pos.latitude, longitude: pos.longitude);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(wea);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      )
    );
  }
}
