import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';

class RandomModel extends RandomEntity {
  const RandomModel({
    required super.id,
    required super.url,
    required super.value,
    required super.iconUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.categories,
  });

  factory RandomModel.fromJson(Map<String, dynamic> json) {
    return RandomModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      value: json['value'] ?? '',
      iconUrl: json['icon_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }
}
