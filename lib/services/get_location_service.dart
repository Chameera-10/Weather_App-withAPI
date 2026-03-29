import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  Future<String> getCityNameFromCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String cityName = placeMarks[0].locality!;
    print(cityName);
    return cityName;
  }
}
