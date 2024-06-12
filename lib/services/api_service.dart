import 'dart:convert';

import 'package:flutter_application_1/model/price_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String url = 'https://paukzay.online/feed/getprices.php?appkey=da0bac00bb514f91652ca2434fe66561c75ded2a4d8e85ad761ded01923fcce0';

  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<PriceModel>> fetchPrices() async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PriceModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load prices');
    }
  }
}
