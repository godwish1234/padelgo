import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../services/interfaces/location_service.dart';

class LocationHelper {
  static LocationService get _locationService =>
      GetIt.instance<LocationService>();

  static Future<bool> updateLocationData() async {
    try {
      if (kDebugMode) {
        print('LocationHelper: Updating location data...');
      }

      bool hasPermission = await _locationService.hasLocationPermission();

      if (!hasPermission) {
        hasPermission = await _locationService.requestLocationPermission();

        if (!hasPermission) {
          if (kDebugMode) {
            print('LocationHelper: Permission denied');
          }
          return false;
        }
      }

      final results = await Future.wait([
        _locationService.getCurrentLocation(),
        _locationService.getIpAddress(),
      ]);

      final location = results[0] as LocationData?;
      final ipAddress = results[1] as String?;

      if (location != null && ipAddress != null) {
        await _locationService.saveLocationData(location, ipAddress);

        if (kDebugMode) {
          print(
              'LocationHelper: Location updated - Lat: ${location.latitude}, Lon: ${location.longitude}, IP: $ipAddress');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('LocationHelper: Failed to get location or IP address');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('LocationHelper: Error updating location data: $e');
      }
      return false;
    }
  }

  static Future<StoredLocationData?> getStoredLocationData() async {
    try {
      return await _locationService.getStoredLocationData();
    } catch (e) {
      if (kDebugMode) {
        print('LocationHelper: Error getting stored location: $e');
      }
      return null;
    }
  }

  static Future<bool> hasValidLocationData() async {
    try {
      final storedData = await getStoredLocationData();
      return storedData?.isValid ?? false;
    } catch (e) {
      if (kDebugMode) {
        print('LocationHelper: Error checking location validity: $e');
      }
      return false;
    }
  }

  static Future<void> clearLocationData() async {
    try {
      await _locationService.clearLocationData();
      if (kDebugMode) {
        print('LocationHelper: Location data cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('LocationHelper: Error clearing location data: $e');
      }
    }
  }

  static Future<bool> updateLocationDataIfNeeded({int maxAgeHours = 24}) async {
    try {
      final storedData = await getStoredLocationData();

      if (storedData?.isValid == true && storedData?.timestamp != null) {
        final timestamp = int.tryParse(storedData!.timestamp!);
        if (timestamp != null) {
          final storedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
          final now = DateTime.now();
          final difference = now.difference(storedTime);

          if (difference.inHours <= maxAgeHours) {
            if (kDebugMode) {
              print('LocationHelper: Existing location data is fresh enough');
            }
            return true;
          }
        }
      }

      if (kDebugMode) {
        print('LocationHelper: Location data needs update');
      }
      return await updateLocationData();
    } catch (e) {
      if (kDebugMode) {
        print('LocationHelper: Error in updateLocationDataIfNeeded: $e');
      }
      return false;
    }
  }

  static void updateLocationDataInBackground() {
    Future.microtask(() async {
      try {
        await updateLocationData();
      } catch (e) {
        if (kDebugMode) {
          print('LocationHelper: Background update failed: $e');
        }
      }
    });
  }
}
