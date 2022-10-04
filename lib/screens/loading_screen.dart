

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  WeatherModel weather=WeatherModel();

  Future<void> getWeather()async{
    var weatherData= await weather.getLocationData();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LocationScreen(weatherData:weatherData)));

  }

  @override
 void initState() {
    super.initState();
    getWeather();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SpinKitDoubleBounce(
       size:100,
       color:Colors.white,


     )
    );



  }
}
