import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:flutter_test/flutter_test.dart';

void randomEntityTest() {
  group('RandomEntity', () {
    test('should correctly create a RandomEntity instance', () {
      const randomEntity = RandomEntity(
        id: '123',
        url: 'https://example.com',
        value: 'Chuck Norris jokes are funny',
        iconUrl: 'https://example.com/icon',
        createdAt: '2023-08-11',
        updatedAt: '2023-08-11',
        categories: ['category1', 'category2'],
      );

      expect(randomEntity.id, '123');
      expect(randomEntity.url, 'https://example.com');
      expect(randomEntity.value, 'Chuck Norris jokes are funny');
      expect(randomEntity.iconUrl, 'https://example.com/icon');
      expect(randomEntity.createdAt, '2023-08-11');
      expect(randomEntity.updatedAt, '2023-08-11');
      expect(randomEntity.categories, ['category1', 'category2']);
    });

    test('should create an empty RandomEntity instance', () {
      final emptyEntity = RandomEntity.empty();

      expect(emptyEntity.id, '');
      expect(emptyEntity.url, '');
      expect(emptyEntity.value, '');
      expect(emptyEntity.iconUrl, '');
      expect(emptyEntity.createdAt, '');
      expect(emptyEntity.updatedAt, '');
      expect(emptyEntity.categories, []);
    });

    test('should correctly override equals and hashCode', () {
      const entity1 = RandomEntity(
        id: '123',
        url: 'https://example.com',
        value: 'Chuck Norris jokes are funny',
        iconUrl: 'https://example.com/icon',
        createdAt: '2023-08-11',
        updatedAt: '2023-08-11',
        categories: ['category1', 'category2'],
      );

      const entity2 = RandomEntity(
        id: '123',
        url: 'https://example.com',
        value: 'Chuck Norris jokes are funny',
        iconUrl: 'https://example.com/icon',
        createdAt: '2023-08-11',
        updatedAt: '2023-08-11',
        categories: ['category1', 'category2'],
      );

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('should correctly implement toString', () {
      const randomEntity = RandomEntity(
        id: '123',
        url: 'https://example.com',
        value: 'Chuck Norris jokes are funny',
        iconUrl: 'https://example.com/icon',
        createdAt: '2023-08-11',
        updatedAt: '2023-08-11',
        categories: ['category1', 'category2'],
      );

      const expectedToString = '''
        Id: 123
        URL: https://example.com
        Value: Chuck Norris jokes are funny
        Icon URL: https://example.com/icon
        Created At: 2023-08-11
        Updated At: 2023-08-11
        Categories: [category1, category2]
        ''';

      expect(randomEntity.toString(), equals(expectedToString));
    });
  });
}
