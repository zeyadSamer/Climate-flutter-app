import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});

  var weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = new WeatherModel();

  int condition;
  int temperature;
  String cityName;
  String weatherMessage;
  String weatherIcon;

  void updateShownWeather({String city}) async {
    // get location weather
    if (city == null) {
      WeatherModel weather = WeatherModel();
      var weatherData = await weather.getLocationData();
      updateUI(weatherData);
    } else {
      WeatherModel weather = WeatherModel();
      var weatherData = await weather.getCityData(city);
      updateUI(weatherData);
    }
  }

  void updateUI(data) {
    setState(() {
      condition = data['weather'][0]['id'];
      temperature = data['main']['temp'].toInt();
      cityName = data['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.weatherData != null) {
      updateUI(widget.weatherData);
    } else {
      temperature = 0;
      cityName = 'your device';
      weatherMessage = 'activate location service';
      weatherIcon = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      updateShownWeather();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));

                      updateShownWeather(city: typedCity);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature° ',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weatherMessage in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
