import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/services/interfaces/home_service.dart';
import 'package:padelgo/models/user_model.dart';
import 'package:padelgo/models/news_model.dart';
import 'package:padelgo/models/partner_model.dart';

class HomeViewModel extends BaseViewModel {
  // User data
  UserModel? user;

  final _homeService = GetIt.I<IHomeService>();

  // News auto-slide
  PageController? _newsPageController;
  Timer? _autoSlideTimer;
  int _currentNewsPage = 0;

  PageController? get newsPageController => _newsPageController;
  int get currentNewsPage => _currentNewsPage;

  // Location state
  String _selectedCity = 'Jakarta Selatan'; // Default city
  String get selectedCity => _selectedCity;

  // Available cities
  final List<String> _cities = [
    'Jakarta Pusat',
    'Jakarta Selatan',
    'Jakarta Utara',
    'Jakarta Barat',
    'Jakarta Timur',
    'Tangerang Selatan',
    'Bekasi',
  ];
  List<String> get cities => _cities;

  // Date selection
  DateTime? _selectedStartDate;
  DateTime? get selectedStartDate => _selectedStartDate;

  DateTime? _selectedEndDate;
  DateTime? get selectedEndDate => _selectedEndDate;

  // Data state
  List<NewsItem> _newsItems = [];
  List<Reminder> _reminders = [];
  List<Venue> _venues = [];
  List<QuickAction> _quickActions = [];

  bool _isLoading = false;
  bool _isLoadingNews = false;
  bool _isLoadingVenues = false;
  bool _isLoadingQuickActions = false;
  String? _errorMessage;

  // Getters
  List<NewsItem> get newsItems => _newsItems;
  List<Reminder> get reminders => _reminders;
  List<Venue> get venues => _venues;
  List<QuickAction> get quickActions => _quickActions;
  bool get isLoading => _isLoading;
  bool get isLoadingNews => _isLoadingNews;
  bool get isLoadingVenues => _isLoadingVenues;
  bool get isLoadingQuickActions => _isLoadingQuickActions;
  String? get errorMessage => _errorMessage;

  // Get urgent reminders for compact view, sorted by nearest due date
  List<Reminder> get urgentReminders {
    final reminders = List<Reminder>.from(_reminders);
    reminders.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return reminders.take(3).toList();
  }

  bool get hasMoreReminders => _reminders.length > 3;

  Future<void> initialize() async {
    _newsPageController = PageController(viewportFraction: 0.9);

    DateTime startDate = DateTime.now().subtract(const Duration(days: 4));
    await updateDate(
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0),
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            23, 59));

    await loadHomeData();
  }

  // Load all home data
  Future<void> loadHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Load data in parallel with individual loading states
      await Future.wait([
        _loadNews(),
        _loadReminders(),
        _loadVenues(),
        _loadQuickActions(),
      ]);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load data: ${e.toString()}';
      notifyListeners();
    }
  }

  // Refresh all data
  Future<void> refreshData() async {
    await loadHomeData();
  }

  // API Methods - Replace with actual API calls

  Future<void> _loadNews() async {
    _isLoadingNews = true;
    notifyListeners();

    try {
      // Fetch news from API
      final news = await _homeService.getNews();
      _newsItems = news
          .map((n) => NewsItem(
                id: n.id.toString(),
                imageUrl: n.image,
                category: n.tag,
                title: n.title,
                subtitle: _getSubtitle(n.content),
                newsModel: n,
              ))
          .toList();
      _isLoadingNews = false;
      notifyListeners();

      // Start auto-slide after news loaded
      if (_newsItems.isNotEmpty) {
        _startAutoSlide();
      }
    } catch (e) {
      _isLoadingNews = false;
      notifyListeners();
      throw Exception('Failed to load news: $e');
    }
  }

  // Helper to get subtitle from content
  String _getSubtitle(String content) {
    if (content.isEmpty) return '';
    final firstLine = content.split('\n').first;
    return firstLine.length > 100
        ? '${firstLine.substring(0, 100)}...'
        : firstLine;
  }

  Future<void> _loadReminders() async {
    try {
      // TODO: Replace with actual API call
      // final response = await _apiService.getReminders();
      // _reminders = response.data.map((e) => Reminder.fromJson(e)).toList();

      // Simulating API call with dummy data
      await Future.delayed(const Duration(milliseconds: 300));
      _reminders = _getDummyReminders();
    } catch (e) {
      throw Exception('Failed to load reminders: $e');
    }
  }

  Future<void> _loadVenues() async {
    _isLoadingVenues = true;
    notifyListeners();

    try {
      // Fetch partners from API
      final List<PartnerModel> partners = await _homeService.getPartners();
      _venues = partners
          .expand((partner) => partner.locations.map((location) => Venue(
                id: location.id.toString(),
                name: location.name,
                address: location.address,
                distance: '${location.city}',
                rating: 4.5,
                reviewCount: 0,
                imageUrl: partner.logo ?? 'https://via.placeholder.com/150',
                priceRange: 'See venue for details',
                category: 'Partner',
                features: [],
                openHours: '',
                description: partner.description ?? '',
                images: [partner.logo ?? 'https://via.placeholder.com/150'],
                reviews: [],
              )))
          .toList();
      _isLoadingVenues = false;
      notifyListeners();
    } catch (e) {
      _isLoadingVenues = false;
      notifyListeners();
      throw Exception('Failed to load venues: $e');
    }
  }

  Future<void> _loadQuickActions() async {
    _isLoadingQuickActions = true;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // final response = await _apiService.getQuickActions();
      // _quickActions = response.data.map((e) => QuickAction.fromJson(e)).toList();

      // Simulating API call with dummy data
      await Future.delayed(const Duration(milliseconds: 300));
      _quickActions = _getDummyQuickActions();
      _isLoadingQuickActions = false;
      notifyListeners();
    } catch (e) {
      _isLoadingQuickActions = false;
      notifyListeners();
      throw Exception('Failed to load quick actions: $e');
    }
  }

  Future<void> bookCourt(String courtId) async {
    // TODO: Implement court booking API call
  }

  Future updateDate(DateTime startDate, DateTime endDate) async {
    _selectedStartDate = startDate;
    _selectedEndDate = endDate;
    notifyListeners();
  }

  // Select city and reload data
  Future<void> selectCity(String city) async {
    if (_selectedCity == city) return;

    _selectedCity = city;
    notifyListeners();

    // Reload home data for the new city
    // For now, using same dummy data for all cities
    await loadHomeData();
  }

  // Get current location (simulated)
  Future<void> useCurrentLocation() async {
    // TODO: Implement actual geolocation
    // For now, simulate getting location and set to Jakarta Selatan
    _selectedCity = 'Jakarta Selatan';
    notifyListeners();

    // Reload data
    await loadHomeData();
  }

  // Auto-slide methods
  void _startAutoSlide() {
    _stopAutoSlide();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_newsPageController != null && _newsItems.isNotEmpty) {
        _currentNewsPage = (_currentNewsPage + 1) % _newsItems.length;
        _newsPageController!.animateToPage(
          _currentNewsPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        notifyListeners();
      }
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
  }

  void onNewsPageChanged(int page) {
    _currentNewsPage = page;
    notifyListeners();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _stopAutoSlide();
    _newsPageController?.dispose();
    super.dispose();
  }


  List<Reminder> _getDummyReminders() {
    final now = DateTime.now();
    return [
      Reminder(
        id: 'rem1',
        type: 'Event',
        title: 'Padel Match',
        time: 'Tomorrow 2:00 PM - Senayan Padel',
        icon: 'sports_tennis',
        dueDate: now.add(const Duration(days: 1)),
      ),
      Reminder(
        id: 'rem2',
        type: 'Payment',
        title: 'Court Booking Payment',
        time: 'Rp 200,000 - Due in 3 days',
        icon: 'credit_card',
        dueDate: now.add(const Duration(days: 3)),
      ),
      Reminder(
        id: 'rem3',
        type: 'Competition',
        title: 'Jakarta Padel League',
        time: '7:00 PM - BSD Padel Arena',
        icon: 'emoji_events',
        dueDate: now.add(const Duration(days: 5)),
      ),
      Reminder(
        id: 'rem4',
        type: 'Event',
        title: 'Padel Coaching Session',
        time: '10:00 AM - Pondok Indah Padel',
        icon: 'sports_tennis',
        dueDate: now.add(const Duration(days: 2)),
      ),
      Reminder(
        id: 'rem5',
        type: 'Reminder',
        title: 'Equipment Return',
        time: 'Padel racket rental due',
        icon: 'fitness_center',
        dueDate: now.add(const Duration(hours: 8)),
      ),
      Reminder(
        id: 'rem6',
        type: 'Event',
        title: 'Group Training Session',
        time: '6:00 AM - Kemayoran Padel',
        icon: 'groups',
        dueDate: now.add(const Duration(days: 7)),
      ),
    ];
  }

  List<QuickAction> _getDummyQuickActions() {
    return [
      // Primary Actions - Main features
      QuickAction(
        id: 'book_court',
        icon: Icons.calendar_month_rounded,
        label: 'Book Court',
        color: const Color(0xFF1E88E5), // Primary Blue
        available: true,
        isPrimary: true,
      ),
      QuickAction(
        id: 'find_players',
        icon: Icons.sports_tennis_rounded,
        label: 'Find Players',
        color: const Color(0xFF10B981), // Green
        available: true,
        isPrimary: true,
      ),
    ];
  }
}

// Models - Should be moved to models folder in production

class NewsItem {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String category;
  final NewsModel? newsModel;

  NewsItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.category,
    this.newsModel,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'category': category,
    };
  }
}

class Reminder {
  final String id;
  final String type;
  final String title;
  final String time;
  final String icon;
  final DateTime dueDate;

  Reminder({
    required this.id,
    required this.type,
    required this.title,
    required this.time,
    required this.icon,
    required this.dueDate,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      time: json['time'] as String,
      icon: json['icon'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'time': time,
      'icon': icon,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}

class Venue {
  final String id;
  final String name;
  final String address;
  final String distance;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String priceRange;
  final String category;
  final List<String> features;
  final String openHours;
  final String description;
  final List<String> images;
  final List<VenueReview> reviews;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.priceRange,
    required this.category,
    required this.features,
    required this.openHours,
    required this.description,
    required this.images,
    required this.reviews,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      distance: json['distance'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      imageUrl: json['imageUrl'] as String,
      priceRange: json['priceRange'] as String,
      category: json['category'] as String,
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      openHours: json['openHours'] as String,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => VenueReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'distance': distance,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrl': imageUrl,
      'priceRange': priceRange,
      'category': category,
      'features': features,
      'openHours': openHours,
      'description': description,
      'images': images,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}

class VenueReview {
  final String name;
  final int rating;
  final String comment;
  final String date;

  VenueReview({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory VenueReview.fromJson(Map<String, dynamic> json) {
    return VenueReview(
      name: json['name'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }
}

class QuickAction {
  final String id;
  final IconData icon;
  final String label;
  final Color color;
  final bool available;
  final bool isPrimary;

  QuickAction({
    required this.id,
    required this.icon,
    required this.label,
    required this.color,
    this.available = true,
    this.isPrimary = false,
  });

  factory QuickAction.fromJson(Map<String, dynamic> json) {
    // TODO: When API is ready, implement icon and color parsing from strings
    // For now, this won't be called as we use local data
    return QuickAction(
      id: json['id'] as String,
      icon: Icons.help_outline, // Default icon
      label: json['label'] as String,
      color: Colors.blue, // Default color
      available: json['available'] as bool? ?? true,
      isPrimary: json['isPrimary'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    // TODO: When API is ready, convert IconData and Color to strings
    return {
      'id': id,
      'icon': icon.codePoint.toString(),
      'label': label,
      'color': color.value.toString(),
      'available': available,
      'isPrimary': isPrimary,
    };
  }
}
