import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CreateActivityViewModel extends BaseViewModel {
  // Selection state
  String? _selectedCity;
  DateTime? _selectedDate;
  String? _selectedCourt;
  Map<String, TimeSlot> _selectedTimeSlots = {};
  double _totalPrice = 0.0;

  // Collapse states
  bool _isCityCollapsed = false;
  bool _isDateCollapsed = false;
  bool _isCourtCollapsed = false;

  // Loading state
  bool _isLoading = false;
  String? _errorMessage;

  // Data
  List<String> _cities = [];
  List<LocationOption> _allLocations = [];
  Map<String, List<CourtOption>> _courtsByLocation = {};
  List<TimeOfDay> _availableTimeSlots = [];

  // Getters
  String? get selectedCity => _selectedCity;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedCourt => _selectedCourt;
  Map<String, TimeSlot> get selectedTimeSlots => _selectedTimeSlots;
  double get totalPrice => _totalPrice;
  bool get isCityCollapsed => _isCityCollapsed;
  bool get isDateCollapsed => _isDateCollapsed;
  bool get isCourtCollapsed => _isCourtCollapsed;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get cities => _cities;
  List<LocationOption> get allLocations => _allLocations;
  Map<String, List<CourtOption>> get courtsByLocation => _courtsByLocation;
  List<TimeOfDay> get availableTimeSlots => _availableTimeSlots;

  // Get all courts available in selected city and date
  List<CourtOptionWithLocation> get availableCourtsForSelectedCityAndDate {
    if (_selectedCity == null || _selectedDate == null) return [];

    final locationsInCity =
        _allLocations.where((loc) => loc.city == _selectedCity).toList();
    final courtsWithLocation = <CourtOptionWithLocation>[];

    for (var location in locationsInCity) {
      final courts = _courtsByLocation[location.name] ?? [];
      for (var court in courts) {
        // TODO: Check actual availability from API based on date
        // For now, we'll show all courts as available
        if (court.isAvailable) {
          courtsWithLocation.add(CourtOptionWithLocation(
            court: court,
            location: location,
          ));
        }
      }
    }

    return courtsWithLocation;
  }

  CourtOptionWithLocation? get selectedCourtData {
    if (_selectedCourt == null) return null;
    return availableCourtsForSelectedCityAndDate.firstWhere(
        (courtWithLoc) => courtWithLoc.court.name == _selectedCourt);
  }

  int get availableCourtsCount {
    return availableCourtsForSelectedCityAndDate.length;
  }

  int get totalVenuesCount {
    if (_selectedCity == null) return 0;
    return _allLocations.where((loc) => loc.city == _selectedCity).length;
  }

  // Initialize and load data
  Future<void> initialize({String? defaultCity}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait([
        _loadCities(),
        _loadLocations(),
        _loadCourts(),
        _loadAvailableTimeSlots(),
      ]);

      _isLoading = false;

      // Set default city if provided and valid
      if (defaultCity != null && _cities.contains(defaultCity)) {
        _selectedCity = defaultCity;
        _isCityCollapsed = true; // Start collapsed when city is pre-selected
      } else if (defaultCity == null && _cities.isNotEmpty) {
        // If no default provided, set Jakarta Selatan as default
        _selectedCity = 'Jakarta Selatan';
        _isCityCollapsed = true;
      }

      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load data: ${e.toString()}';
      notifyListeners();
    }
  }

  // API Methods - Replace with actual API calls
  Future<void> _loadCities() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 300));
    _cities = [
      'Jakarta Pusat',
      'Jakarta Selatan',
      'Jakarta Utara',
      'Jakarta Barat',
      'Jakarta Timur',
      'Tangerang Selatan',
      'Bekasi',
    ];
  }

  Future<void> _loadLocations() async {
    // TODO: Replace with actual API call
    // final response = await _apiService.getLocations();
    // _allLocations = response.data.map((e) => LocationOption.fromJson(e)).toList();

    await Future.delayed(const Duration(milliseconds: 300));
    _allLocations = _getDummyLocations();
  }

  Future<void> _loadCourts() async {
    // TODO: Replace with actual API call
    // final response = await _apiService.getCourts();
    // _courtsByLocation = response.data;

    await Future.delayed(const Duration(milliseconds: 300));
    _courtsByLocation = _getDummyCourts();
  }

  Future<void> _loadAvailableTimeSlots() async {
    // TODO: Replace with actual API call
    // final response = await _apiService.getAvailableTimeSlots();
    // _availableTimeSlots = response.data;

    await Future.delayed(const Duration(milliseconds: 300));
    _availableTimeSlots = _getDummyTimeSlots();
  }

  // Selection methods
  void selectCity(String city) {
    _selectedCity = city;
    _selectedDate = null;
    _selectedCourt = null;
    _selectedTimeSlots.clear();
    _totalPrice = 0.0;
    _isCityCollapsed = true;
    _isDateCollapsed = false;
    _isCourtCollapsed = false;
    notifyListeners();
  }

  void toggleCityCollapse() {
    _isCityCollapsed = !_isCityCollapsed;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _selectedCourt = null;
    _selectedTimeSlots.clear();
    _totalPrice = 0.0;
    _isDateCollapsed = true;
    _isCourtCollapsed = false;
    notifyListeners();
  }

  void toggleDateCollapse() {
    _isDateCollapsed = !_isDateCollapsed;
    notifyListeners();
  }

  void selectCourt(String court) {
    _selectedCourt = court;
    _selectedTimeSlots.clear();
    _totalPrice = 0.0;
    _isCourtCollapsed = true;
    notifyListeners();
  }

  void toggleCourtCollapse() {
    _isCourtCollapsed = !_isCourtCollapsed;
    notifyListeners();
  }

  void toggleTimeSlot(TimeOfDay time) {
    if (_selectedDate == null) return;
    final key =
        '${DateFormat('yyyy-MM-dd').format(_selectedDate!)}_${time.hour}:${time.minute}';

    if (_selectedTimeSlots.containsKey(key)) {
      _selectedTimeSlots.remove(key);
    } else {
      _selectedTimeSlots[key] = TimeSlot(date: _selectedDate!, time: time);
    }

    _updateTotalPrice();
    notifyListeners();
  }

  bool isTimeSlotSelected(DateTime date, TimeOfDay time) {
    final key =
        '${DateFormat('yyyy-MM-dd').format(date)}_${time.hour}:${time.minute}';
    return _selectedTimeSlots.containsKey(key);
  }

  void _updateTotalPrice() {
    if (selectedCourtData != null) {
      _totalPrice =
          _selectedTimeSlots.length * selectedCourtData!.court.pricePerHour;
    } else {
      _totalPrice = 0.0;
    }
  }

  // Dummy data methods
  List<LocationOption> _getDummyLocations() {
    return [
      // Jakarta Pusat
      LocationOption(
        id: '1',
        name: 'Padel Park Senayan',
        address: 'Jl. Pintu Satu Senayan, Gelora',
        distance: '2.1 km',
        city: 'Jakarta Pusat',
        icon: 'sports_tennis',
        imageUrl:
            'https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0',
        totalCourts: 4,
        openTime: '06:00',
        closeTime: '22:00',
        rating: 4.8,
        facilities: ['Locker Room', 'Shower', 'Parking', 'Cafe'],
      ),
      LocationOption(
        id: '2',
        name: 'Central Padel Club',
        address: 'Jl. Sudirman Kav 52, Tanah Abang',
        distance: '3.5 km',
        city: 'Jakarta Pusat',
        icon: 'sports_tennis',
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        totalCourts: 6,
        openTime: '07:00',
        closeTime: '23:00',
        rating: 4.9,
        facilities: [
          'Locker Room',
          'Shower',
          'Parking',
          'Pro Shop',
          'Restaurant'
        ],
      ),

      // Jakarta Selatan
      LocationOption(
        id: '3',
        name: 'Pondok Indah Padel Center',
        address: 'Jl. Metro Pondok Indah, Kebayoran Lama',
        distance: '5.3 km',
        city: 'Jakarta Selatan',
        icon: 'sports_tennis',
        imageUrl:
            'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6',
        totalCourts: 8,
        openTime: '06:00',
        closeTime: '22:00',
        rating: 4.7,
        facilities: [
          'Locker Room',
          'Shower',
          'Parking',
          'Cafe',
          'Equipment Rental'
        ],
      ),
      LocationOption(
        id: '4',
        name: 'Kemang Padel Arena',
        address: 'Jl. Kemang Raya No. 25, Mampang',
        distance: '6.8 km',
        city: 'Jakarta Selatan',
        icon: 'sports_tennis',
        imageUrl: 'https://images.unsplash.com/photo-1544965503-7ad531123fcf',
        totalCourts: 5,
        openTime: '07:00',
        closeTime: '22:00',
        rating: 4.6,
        facilities: ['Parking', 'Cafe', 'Equipment Rental'],
      ),

      // Jakarta Utara
      LocationOption(
        id: '5',
        name: 'Kelapa Gading Padel Club',
        address: 'Jl. Boulevard Barat, Kelapa Gading',
        distance: '8.2 km',
        city: 'Jakarta Utara',
        icon: 'sports_tennis',
        imageUrl:
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b',
        totalCourts: 6,
        openTime: '06:00',
        closeTime: '23:00',
        rating: 4.8,
        facilities: ['Locker Room', 'Shower', 'Parking', 'Pro Shop', 'Cafe'],
      ),

      // Jakarta Barat
      LocationOption(
        id: '6',
        name: 'Tanjung Duren Padel Court',
        address: 'Jl. Tanjung Duren Raya, Grogol',
        distance: '7.5 km',
        city: 'Jakarta Barat',
        icon: 'sports_tennis',
        imageUrl:
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96',
        totalCourts: 4,
        openTime: '07:00',
        closeTime: '22:00',
        rating: 4.5,
        facilities: ['Parking', 'Cafe'],
      ),

      // Jakarta Timur
      LocationOption(
        id: '7',
        name: 'Klender Padel Sports',
        address: 'Jl. Pemuda, Rawamangun',
        distance: '9.1 km',
        city: 'Jakarta Timur',
        icon: 'sports_tennis',
        imageUrl:
            'https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0',
        totalCourts: 3,
        openTime: '06:00',
        closeTime: '21:00',
        rating: 4.4,
        facilities: ['Parking', 'Locker Room'],
      ),

      // Tangerang Selatan
      LocationOption(
        id: '8',
        name: 'BSD Padel Arena',
        address: 'Jl. BSD Raya Utama, Serpong',
        distance: '18.2 km',
        city: 'Tangerang Selatan',
        icon: 'sports_tennis',
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        totalCourts: 10,
        openTime: '06:00',
        closeTime: '23:00',
        rating: 4.9,
        facilities: [
          'Locker Room',
          'Shower',
          'Parking',
          'Pro Shop',
          'Restaurant',
          'Coaching'
        ],
      ),
      LocationOption(
        id: '9',
        name: 'Alam Sutera Padel Club',
        address: 'Jl. Alam Sutera Boulevard, Pakulonan',
        distance: '16.5 km',
        city: 'Tangerang Selatan',
        icon: 'sports_tennis',
        imageUrl:
            'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6',
        totalCourts: 7,
        openTime: '07:00',
        closeTime: '22:00',
        rating: 4.7,
        facilities: ['Locker Room', 'Parking', 'Cafe', 'Equipment Rental'],
      ),

      // Bekasi
      LocationOption(
        id: '10',
        name: 'Summarecon Padel Center',
        address: 'Jl. Boulevard Hijau, Summarecon Bekasi',
        distance: '22.3 km',
        city: 'Bekasi',
        icon: 'sports_tennis',
        imageUrl: 'https://images.unsplash.com/photo-1544965503-7ad531123fcf',
        totalCourts: 5,
        openTime: '06:00',
        closeTime: '22:00',
        rating: 4.6,
        facilities: ['Locker Room', 'Shower', 'Parking', 'Cafe'],
      ),
    ];
  }

  Map<String, List<CourtOption>> _getDummyCourts() {
    // Generate Padel courts for each location
    final courtsMap = <String, List<CourtOption>>{};

    courtsMap['Padel Park Senayan'] = [
      CourtOption(
        id: 'court_1',
        name: 'Padel Court 1 - Outdoor',
        sport: 'Padel',
        pricePerHour: 180000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0',
        description:
            'Professional outdoor padel court with panoramic glass walls and artificial turf',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
      CourtOption(
        id: 'court_2',
        name: 'Padel Court 2 - Indoor',
        sport: 'Padel',
        pricePerHour: 220000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF2196F3,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        description:
            'Climate-controlled indoor padel court with professional lighting',
        surfaceType: 'Artificial Turf',
        isIndoor: true,
      ),
      CourtOption(
        id: 'court_3',
        name: 'Padel Court 3 - Outdoor',
        sport: 'Padel',
        pricePerHour: 180000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6',
        description: 'Standard outdoor padel court perfect for casual games',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
      CourtOption(
        id: 'court_4',
        name: 'Padel Court 4 - Premium Indoor',
        sport: 'Padel',
        pricePerHour: 250000.0,
        icon: 'sports_tennis',
        colorValue: 0xFFFF9800,
        isAvailable: false,
        imageUrl: 'https://images.unsplash.com/photo-1544965503-7ad531123fcf',
        description: 'Premium indoor court with tournament-grade facilities',
        surfaceType: 'Professional Turf',
        isIndoor: true,
      ),
    ];

    courtsMap['Central Padel Club'] = [
      CourtOption(
        id: 'court_5',
        name: 'Championship Court 1',
        sport: 'Padel',
        pricePerHour: 280000.0,
        icon: 'sports_tennis',
        colorValue: 0xFFFF9800,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0',
        description:
            'Championship-level indoor padel court with spectator seating',
        surfaceType: 'Professional Turf',
        isIndoor: true,
      ),
      CourtOption(
        id: 'court_6',
        name: 'Padel Court 2',
        sport: 'Padel',
        pricePerHour: 230000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF2196F3,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        description: 'Indoor padel court with premium amenities',
        surfaceType: 'Artificial Turf',
        isIndoor: true,
      ),
    ];

    courtsMap['Pondok Indah Padel Center'] = [
      CourtOption(
        id: 'court_7',
        name: 'Padel Court A',
        sport: 'Padel',
        pricePerHour: 200000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6',
        description: 'Outdoor padel court in premium location',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
      CourtOption(
        id: 'court_8',
        name: 'Padel Court B',
        sport: 'Padel',
        pricePerHour: 200000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        description: 'Outdoor padel court with modern facilities',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
    ];

    courtsMap['Kemang Padel Arena'] = [
      CourtOption(
        id: 'court_9',
        name: 'Padel Court 1',
        sport: 'Padel',
        pricePerHour: 190000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF2196F3,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0',
        description: 'Semi-outdoor padel court in trendy Kemang area',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
    ];

    courtsMap['Kelapa Gading Padel Club'] = [
      CourtOption(
        id: 'court_10',
        name: 'Indoor Padel Court 1',
        sport: 'Padel',
        pricePerHour: 240000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF2196F3,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        description: 'Premium indoor padel court with AC',
        surfaceType: 'Professional Turf',
        isIndoor: true,
      ),
      CourtOption(
        id: 'court_11',
        name: 'Indoor Padel Court 2',
        sport: 'Padel',
        pricePerHour: 240000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF2196F3,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1544965503-7ad531123fcf',
        description: 'Premium indoor padel court with AC',
        surfaceType: 'Professional Turf',
        isIndoor: true,
      ),
    ];

    courtsMap['Tanjung Duren Padel Court'] = [
      CourtOption(
        id: 'court_12',
        name: 'Padel Court 1',
        sport: 'Padel',
        pricePerHour: 170000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6',
        description: 'Affordable outdoor padel court',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
    ];

    courtsMap['Klender Padel Sports'] = [
      CourtOption(
        id: 'court_13',
        name: 'Padel Court 1',
        sport: 'Padel',
        pricePerHour: 160000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0',
        description: 'Budget-friendly outdoor padel court',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
    ];

    courtsMap['BSD Padel Arena'] = [
      CourtOption(
        id: 'court_14',
        name: 'Championship Court',
        sport: 'Padel',
        pricePerHour: 300000.0,
        icon: 'sports_tennis',
        colorValue: 0xFFFF9800,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        description:
            'World-class indoor padel court with tournament facilities',
        surfaceType: 'Tournament Grade',
        isIndoor: true,
      ),
      CourtOption(
        id: 'court_15',
        name: 'Padel Court 2',
        sport: 'Padel',
        pricePerHour: 250000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF2196F3,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6',
        description: 'Premium indoor padel court',
        surfaceType: 'Professional Turf',
        isIndoor: true,
      ),
      CourtOption(
        id: 'court_16',
        name: 'Padel Court 3',
        sport: 'Padel',
        pricePerHour: 220000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1544965503-7ad531123fcf',
        description: 'Standard indoor padel court',
        surfaceType: 'Artificial Turf',
        isIndoor: true,
      ),
    ];

    courtsMap['Alam Sutera Padel Club'] = [
      CourtOption(
        id: 'court_17',
        name: 'Padel Court 1',
        sport: 'Padel',
        pricePerHour: 210000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF2196F3,
        isAvailable: true,
        imageUrl:
            'https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0',
        description: 'Modern indoor padel court',
        surfaceType: 'Artificial Turf',
        isIndoor: true,
      ),
    ];

    courtsMap['Summarecon Padel Center'] = [
      CourtOption(
        id: 'court_18',
        name: 'Padel Court 1',
        sport: 'Padel',
        pricePerHour: 190000.0,
        icon: 'sports_tennis',
        colorValue: 0xFF4CAF50,
        isAvailable: true,
        imageUrl: 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8',
        description: 'Outdoor padel court in Bekasi',
        surfaceType: 'Artificial Turf',
        isIndoor: false,
      ),
    ];

    return courtsMap;
  }

  List<TimeOfDay> _getDummyTimeSlots() {
    return List.generate(16, (index) => TimeOfDay(hour: 6 + index, minute: 0));
  }
}

// Models
class LocationOption {
  final String id;
  final String name;
  final String address;
  final String distance;
  final String city;
  final String icon;
  final String imageUrl;
  final int totalCourts;
  final String openTime;
  final String closeTime;
  final double rating;
  final List<String> facilities;

  LocationOption({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.city,
    required this.icon,
    required this.imageUrl,
    required this.totalCourts,
    required this.openTime,
    required this.closeTime,
    required this.rating,
    required this.facilities,
  });

  factory LocationOption.fromJson(Map<String, dynamic> json) {
    return LocationOption(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      distance: json['distance'] as String,
      city: json['city'] as String,
      icon: json['icon'] as String,
      imageUrl: json['imageUrl'] as String,
      totalCourts: json['totalCourts'] as int,
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
      rating: (json['rating'] as num).toDouble(),
      facilities: List<String>.from(json['facilities'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'distance': distance,
      'city': city,
      'icon': icon,
      'imageUrl': imageUrl,
      'totalCourts': totalCourts,
      'openTime': openTime,
      'closeTime': closeTime,
      'rating': rating,
      'facilities': facilities,
    };
  }
}

class CourtOption {
  final String id;
  final String name;
  final String sport;
  final double pricePerHour;
  final String icon;
  final int colorValue;
  final bool isAvailable;
  final String imageUrl;
  final String description;
  final String surfaceType;
  final bool isIndoor;

  CourtOption({
    required this.id,
    required this.name,
    required this.sport,
    required this.pricePerHour,
    required this.icon,
    required this.colorValue,
    required this.isAvailable,
    required this.imageUrl,
    required this.description,
    required this.surfaceType,
    required this.isIndoor,
  });

  Color get color => Color(colorValue);

  factory CourtOption.fromJson(Map<String, dynamic> json) {
    return CourtOption(
      id: json['id'] as String,
      name: json['name'] as String,
      sport: json['sport'] as String,
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      icon: json['icon'] as String,
      colorValue: json['colorValue'] as int,
      isAvailable: json['isAvailable'] as bool,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      surfaceType: json['surfaceType'] as String,
      isIndoor: json['isIndoor'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sport': sport,
      'pricePerHour': pricePerHour,
      'icon': icon,
      'colorValue': colorValue,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'description': description,
      'surfaceType': surfaceType,
      'isIndoor': isIndoor,
    };
  }
}

class CourtOptionWithLocation {
  final CourtOption court;
  final LocationOption location;

  CourtOptionWithLocation({
    required this.court,
    required this.location,
  });
}

class TimeSlot {
  final DateTime date;
  final TimeOfDay time;

  TimeSlot({
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'hour': time.hour,
      'minute': time.minute,
    };
  }
}
