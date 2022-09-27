import 'dart:convert';

class LocalCategory {
  final int? id;
  final String? name;

  LocalCategory({this.id, this.name});

  factory LocalCategory.fromJson(Map<String, dynamic> json) {
    return LocalCategory(id: json['id'], name: json['name']);
  }

  static Map<String, dynamic>? toMap(LocalCategory category) => {
        'id': category.id,
        'name': category.name,
      };

  static String encode(List<LocalCategory> categories) => json.encode(
        categories
            .map<Map<String, dynamic>?>(
                (category) => LocalCategory.toMap(category))
            .toList(),
      );

  static List<LocalCategory> decode(String category) =>
      (json.decode(category) as List<dynamic>)
          .map<LocalCategory>((item) => LocalCategory.fromJson(item))
          .toList();
}
