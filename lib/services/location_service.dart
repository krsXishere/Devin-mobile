import 'package:devin/models/location_model.dart';
import 'package:location/location.dart';
import 'dart:async';

class LocationService {
  Location location = Location();
  StreamController<LocationModel> locationStreamController =
      StreamController<LocationModel>();
  Stream<LocationModel> get locationStream => locationStreamController.stream;

  LocationService() {
    location.requestPermission().then(
      (permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          location.onLocationChanged.listen(
            (locationData) {
              // ignore: unnecessary_null_comparison
              if (locationData != null) {
                locationStreamController.add(
                  LocationModel(
                    latitude: locationData.latitude,
                    longitude: locationData.longitude,
                  ),
                );
              }
            },
          );
        } else {
          throw Exception();
        }
      },
    );
  }

  void dispose() {
    locationStreamController.close();
  }
}
