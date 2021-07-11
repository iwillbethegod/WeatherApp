import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_map_weather_api/open_map_weather_api.dart';
import 'package:clima/services/weather.dart';
import 'loading_screen.dart';
import 'city_screen.dart';

OpenWeather openWeather = OpenWeather('f875808edaf93c2e98f0b1908ed7e8c1');

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locWea);
    final Weather locWea;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LoadingScreen lds=LoadingScreen();
  WeatherModel weaData=WeatherModel();
  String temp;
  String img;
  int condition;
  String city;
  String weaIcon;
  String weaMessage;

  @override
  void initState(){
    super.initState();
    updateUi(widget.locWea);

  }

  void updateUi(var wea){
    temp=wea.temperature.toString().substring(0,6);
    int temper=int.parse(temp.substring(0,2));
    condition=wea.weatherConditionCode;
    weaIcon=weaData.getWeatherIcon(condition);
    weaMessage=weaData.getMessage(temper);
    city=wea.areaName;
    img="";

    if (temper > 25&&condition==800) {
      img= 'sun';
    } else if (condition < 600) {
      img= 'rain';
    } else if (condition <400||condition<=804) {
      img= 'cloud';
    } else if(temper<10){
      img= 'snow';
    }
    else
      img='sun';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.33,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      //textMessage,
                      //icon
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(weaMessage,style: kMessageTextStyle),
                        Text(weaIcon,style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  ),
                  //temp
                  Text(temp,style: kTempTextStyle)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Container(
                  
                  child: Image(
                    image: AssetImage('images/$img.png'),fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FlatButton(
                        onPressed: () {
                          setState(() async{
                            var inputValue=await Navigator.push(context, MaterialPageRoute(builder: (context){
                              return CityScreen();
                            }));
                            print(inputValue);
                            Weather wea= await openWeather.currentWeatherByCityName(cityName: inputValue);
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return LocationScreen(wea);
                            }));
                          });
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return LoadingScreen();
                            }));
                          });
                        },
                        child: Icon(
                          Icons.location_on,
                          size: 50.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}



