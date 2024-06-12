import 'package:flutter_application_1/model/price_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

@GenerateMocks([ApiService, Database])
void main() {
  group('PriceProvider', () {
    test('fetches prices and updates state', () async {
      final apiService = MockApiService(ApiService());
      final dbService = MockDatabaseService();

      when(apiService.fetchPrices()).thenAnswer((_) async => [
            PriceModel(id: '1', name: 'Test', price: 10.0),
          ]);

      final priceProvider =  PriceProvider();

      await priceProvider.fetchAndSavePrices();

      expect(priceProvider.prices.length, 1);
      expect(priceProvider.prices.first.name, 'Test');
    });
  });
}

PriceProvider() {
}

class MockDatabaseService {
}

MockApiService(ApiService apiService) {
}
