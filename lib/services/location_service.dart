import 'package:location/location.dart';

class LocationService{
  
  Future<String> getLocation() async {
  Location location = Location();

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return 'Location service is not enabled';
    }
  }

  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return 'Location permission not granted';
    }
  }

  LocationData userLocation = await location.getLocation();

  return '${userLocation.latitude}, ${userLocation.longitude}';
}

}