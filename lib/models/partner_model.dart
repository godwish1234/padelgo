class PartnerLocationModel {
  final int id;
  final int partnerId;
  final String name;
  final String city;
  final String address;
  final double latitude;
  final double longitude;

  PartnerLocationModel({
    required this.id,
    required this.partnerId,
    required this.name,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory PartnerLocationModel.fromJson(Map<String, dynamic> json) {
    return PartnerLocationModel(
      id: json['id'],
      partnerId: json['partner_id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partner_id': partnerId,
      'name': name,
      'city': city,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PartnerModel {
  final int id;
  final String name;
  final String? description;
  final String? logo;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final List<PartnerLocationModel> locations;

  PartnerModel({
    required this.id,
    required this.name,
    this.description,
    this.logo,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.locations,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      locations: (json['locations'] as List?)
              ?.map((loc) => PartnerLocationModel.fromJson(loc))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'locations': locations.map((loc) => loc.toJson()).toList(),
    };
  }
}

class PartnerListResponse {
  final bool success;
  final String message;
  final List<PartnerModel> data;
  final PaginationModel pagination;

  PartnerListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory PartnerListResponse.fromJson(Map<String, dynamic> json) {
    return PartnerListResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((partner) => PartnerModel.fromJson(partner))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((partner) => partner.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class PaginationModel {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int from;
  final int to;

  PaginationModel({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.from,
    required this.to,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'last_page': lastPage,
      'from': from,
      'to': to,
    };
  }
}
