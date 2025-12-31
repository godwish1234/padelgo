class NewsModel {
  final int id;
  final String title;
  final String content;
  final String tag;
  final String createdAt;
  final String updatedAt;
  final String image;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.tag,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      tag: json['tag'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'tag': tag,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image': image,
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

class NewsListResponse {
  final bool success;
  final String message;
  final List<NewsModel> data;
  final PaginationModel pagination;

  NewsListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory NewsListResponse.fromJson(Map<String, dynamic> json) {
    return NewsListResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((newsJson) => NewsModel.fromJson(newsJson))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((news) => news.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}
