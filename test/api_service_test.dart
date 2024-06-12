import 'package:flutter_application_1/model/price_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';



@GenerateMocks([http.Client])
void main() {
  group('fetchPrices', () {
    test('returns a list of prices if the http call completes successfully', () async {
      final client = MockClient();

      when(client.get(Uri.parse(ApiService.url)))
          .thenAnswer((_) async => http.Response('[{"id": "1", "name": "Test", "price": 10.0}]', 200));

      final apiService = ApiService(client: client);
      expect(await apiService.fetchPrices(), isA<List<PriceModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse(ApiService.url)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final apiService = ApiService(client: client);
      expect(apiService.fetchPrices(), throwsException);
    });
  });
}
