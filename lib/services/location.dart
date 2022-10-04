import 'package:geolocator/geolocator.dart';

class Location{

  double latitude;
  double longtitude;

   Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(

          desiredAccuracy: LocationAccuracy.low
      );

      longtitude = position.longitude;
      latitude = position.latitude;



    } catch(e){

      print(e);


    }



  }






}