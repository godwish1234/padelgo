import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../interfaces/location_service.dart';
import '../../utils/secure_storage_util.dart';

class LocationServiceImpl implements LocationService {
  static const String _ipServiceUrl = 'https://api.ipify.org?format=text';
  static const int _locationTimeoutSeconds = 15;
  static const int _ipTimeoutSeconds = 10;

  @override
  Future<LocationData?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print('Location services are disabled.');
        }
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('Location permissions are denied');
          }
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (kDebugMode) {
          print('Location permissions are permanently denied');
        }
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: _locationTimeoutSeconds),
      );

      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current location: $e');
      }
      return null;
    }
  }

  @override
  Future<String?> getIpAddress() async {
    try {
      final cachedIp = await SecureStorageUtil.getIpAddress();
      if (cachedIp != null && cachedIp.isNotEmpty && cachedIp != '0.0.0.0') {
        if (kDebugMode) {
          print('Using cached IP address: $cachedIp');
        }
        _refreshIpInBackground();
        return cachedIp;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting cached IP: $e');
      }
    }

    return await _getIpAddressWithRetry(maxRetries: 2);
  }

  Future<String?> _getIpAddressWithRetry({int maxRetries = 2}) async {
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        if (kDebugMode && attempt > 0) {
          if (kDebugMode) {
            print('IP retrieval attempt ${attempt + 1}/${maxRetries + 1}');
          }
        }

        final response = await http
            .get(
              Uri.parse(_ipServiceUrl),
            )
            .timeout(const Duration(seconds: _ipTimeoutSeconds));

        if (response.statusCode == 200) {
          final ip = response.body.trim();
          if (ip.isNotEmpty) {
            try {
              await SecureStorageUtil.saveIpAddress(ip);
              if (kDebugMode) {
                print('✅ IP address retrieved and cached: $ip');
              }
            } catch (e) {
              if (kDebugMode) {
                print('Failed to cache IP: $e');
              }
            }
            return ip;
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(
              'Error getting external IP address (attempt ${attempt + 1}): $e');
        }
      }

      if (attempt < maxRetries) {
        await Future.delayed(Duration(milliseconds: 500 * (attempt + 1)));
      }
    }

    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback && addr.type == InternetAddressType.IPv4) {
            final localIp = addr.address;
            if (kDebugMode) {
              print('Using local IP address: $localIp');
            }
            try {
              await SecureStorageUtil.saveIpAddress(localIp);
            } catch (e) {
              if (kDebugMode) {
                print('Failed to cache local IP: $e');
              }
            }
            return localIp;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting local IP address: $e');
      }
    }

    if (kDebugMode) {
      print('⚠️ All IP retrieval methods failed - returning placeholder');
    }
    return '0.0.0.0';
  }

  void _refreshIpInBackground() {
    Future.microtask(() async {
      try {
        final response = await http
            .get(Uri.parse(_ipServiceUrl))
            .timeout(const Duration(seconds: _ipTimeoutSeconds));

        if (response.statusCode == 200) {
          final newIp = response.body.trim();
          if (newIp.isNotEmpty) {
            await SecureStorageUtil.saveIpAddress(newIp);
            if (kDebugMode) {
              print('Background IP refresh successful: $newIp');
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Background IP refresh failed: $e');
        }
      }
    });
  }

  @override
  Future<void> saveLocationData(LocationData location, String ipAddress) async {
    try {
      await SecureStorageUtil.saveLocationData(
        latitude: location.latitude.toString(),
        longitude: location.longitude.toString(),
        ipAddress: ipAddress,
      );
      if (kDebugMode) {
        print('Location data saved successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving location data: $e');
      }
      rethrow;
    }
  }

  @override
  Future<StoredLocationData?> getStoredLocationData() async {
    try {
      final locationData = await SecureStorageUtil.getLocationData();
      return StoredLocationData(
        latitude: locationData['latitude'],
        longitude: locationData['longitude'],
        ipAddress: locationData['ipAddress'],
        timestamp: locationData['timestamp'],
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error getting stored location data: $e');
      }
      return null;
    }
  }

  @override
  Future<bool> hasLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking location permission: $e');
      }
      return false;
    }
  }

  @override
  Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting location permission: $e');
      }
      return false;
    }
  }

  @override
  Future<void> clearLocationData() async {
    try {
      await SecureStorageUtil.clearLocationData();
      if (kDebugMode) {
        print('Location data cleared successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing location data: $e');
      }
      rethrow;
    }
  }

  /// Convenience method to get fresh location and IP data
  Future<StoredLocationData?> updateLocationData() async {
    try {
      // Get current location and IP in parallel
      final results = await Future.wait([
        getCurrentLocation(),
        getIpAddress(),
      ]);

      final locationData = results[0] as LocationData?;
      final ipAddress = results[1] as String?;

      if (locationData != null && ipAddress != null) {
        await saveLocationData(locationData, ipAddress);
        return StoredLocationData(
          latitude: locationData.latitude.toString(),
          longitude: locationData.longitude.toString(),
          ipAddress: ipAddress,
          timestamp: locationData.timestamp.millisecondsSinceEpoch.toString(),
        );
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error updating location data: $e');
      }
      return null;
    }
  }

  bool isLocationDataFresh(StoredLocationData? data, {int maxAgeHours = 24}) {
    if (data?.timestamp == null) return false;

    try {
      final timestamp = int.parse(data!.timestamp!);
      final storedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(storedTime);

      return difference.inHours <= maxAgeHours;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking location data freshness: $e');
      }
      return false;
    }
  }
}
