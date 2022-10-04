import '../services/location.dart';
import '../services/networking.dart';
import 'package:clima/screens/location_screen.dart';

String apiKey='3685b3f8659ce3f81cc381117687b906';
String baseUrl='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {



  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }



  Future<dynamic> getCityData(String cityName) async{

    NetworkOperation networkOperation = NetworkOperation(
        '$baseUrl?q=$cityName&appid=$apiKey&units=metric');

    var  cityWeatherData=await networkOperation.getData();

    return cityWeatherData;





  }


  Future<dynamic> getLocationData() async{

    Location location= new Location();

    await location.getCurrentLocation();
    NetworkOperation networkOperation=new NetworkOperation(

        '$baseUrl?lat=${location.latitude}&lon=${location.longtitude}&appid=$apiKey&units=metric'

    );
    var weatherData=await networkOperation.getData();
    return weatherData;




  }
}
