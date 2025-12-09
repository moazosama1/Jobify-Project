import 'package:geolocator/geolocator.dart';
import 'package:initialize_project/generated/l10n.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocationManager {

  Future<void> _checkServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(AppLocalizations().locationServicesAreDisabled);
    }
  }

  Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception(AppLocalizations().locationPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(AppLocalizations().locationPermissionPermanentlyDenied);
    }
  }

  Future<Position> getCurrentLocation({
    LocationAccuracy accuracy = LocationAccuracy.medium,
    int distanceFilter = 10,
  }) async {
    await _checkServiceEnabled();
    await _checkPermission();

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.medium,
    int distanceFilter = 10,
  }) async* {
    await _checkServiceEnabled();
    await _checkPermission();

    yield* Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }
}
