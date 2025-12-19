abstract class LocationService {
  /// Get current user location (lat, lon)
  Future<LocationData?> getCurrentLocation();

  /// Get user's IP address
  Future<String?> getIpAddress();

  /// Save location data to secure storage
  Future<void> saveLocationData(LocationData location, String ipAddress);

  /// Get stored location data from secure storage
  Future<StoredLocationData?> getStoredLocationData();

  /// Check if location permissions are granted
  Future<bool> hasLocationPermission();

  Future<bool> requestLocationPermission();

  /// Clear stored location data
  Future<void> clearLocationData();
}

class LocationData {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, String> toMap() {
    return {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'timestamp': timestamp.millisecondsSinceEpoch.toString(),
    };
  }
}

class StoredLocationData {
  final String? latitude;
  final String? longitude;
  final String? ipAddress;
  final String? timestamp;

  StoredLocationData({
    this.latitude,
    this.longitude,
    this.ipAddress,
    this.timestamp,
  });

  bool get isValid =>
      latitude != null &&
      longitude != null &&
      ipAddress != null &&
      timestamp != null;

  Map<String, String> toHeaders() {
    return {
      if (latitude != null) 'lat': latitude!,
      if (longitude != null) 'lon': longitude!,
      if (ipAddress != null) 'user-ip': ipAddress!,
    };
  }
}
