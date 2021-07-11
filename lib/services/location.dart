import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_map_weather_api/open_map_weather_api.dart';
import 'networking.dart';
import 'package:clima/screens/loading_screen.dart';

OpenWeather openWeather = OpenWeather('f875808edaf93c2e98f0b1908ed7e8c1');

  class LocAndData{
    LoadingScreen lds=LoadingScreen();


  }