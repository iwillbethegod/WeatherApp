import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_map_weather_api/open_map_weather_api.dart';

OpenWeather openWeather = OpenWeather('f875808edaf93c2e98f0b1908ed7e8c1');

class NetworkData{
  Position position;
  Weather weather;
  Temperature temp;
  String city;
  int id;

  Future<Position> getLocation()async{
    position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return (position);
  }

  Future<Weather> getData(double latitude, double longitude) async{
    weather = await openWeather.currentWeatherByLocation(latitude: latitude, longitude: longitude);
    temp=weather.temperature;
    city=weather.areaName;
    id=weather.weatherConditionCode;

    print(id);
    print(temp);
    print(city);
    return weather;
  }
}