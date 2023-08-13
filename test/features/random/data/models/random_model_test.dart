import 'package:chuck_norris_io/features/random/data/models/random.dart';
import 'package:flutter_test/flutter_test.dart';

void randomModelTest() {
  test('fromJson should create a RandomModel from JSON', () {
    final json = {
      'id': '123',
      'url': 'https://example.com',
      'value': 'Chuck Norris jokes',
      'icon_url': 'https://example.com/icon',
      'created_at': '2023-08-10T00:00:00Z',
      'updated_at': '2023-08-11T00:00:00Z',
      'categories': ['funny', 'humor'],
    };

    final randomModel = RandomModel.fromJson(json);

    expect(randomModel.id, '123');
    expect(randomModel.url, 'https://example.com');
    expect(randomModel.value, 'Chuck Norris jokes');
    expect(randomModel.iconUrl, 'https://example.com/icon');
    expect(randomModel.createdAt, '2023-08-10T00:00:00Z');
    expect(randomModel.updatedAt, '2023-08-11T00:00:00Z');
    expect(randomModel.categories, ['funny', 'humor']);
  });
}
