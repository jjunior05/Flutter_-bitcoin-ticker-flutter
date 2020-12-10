import 'package:http/http.dart' as http;
import 'models/coin.dart';
import 'dart:convert';
import 'dart:io';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiKey = 'A11ABF45-9658-419F-9C3B-C4FB4AB284FE';

class CoinData {
  Future getCoin(selectedCurrency) async {
    try {
      Map<String, String> cryptoPrices = {};

      for (var crypto in cryptoList) {
        final apiUrl =
            'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=$apiKey';
        var response = await http.get(apiUrl);
        if (response.statusCode == 200) {
          var decodeData = jsonDecode(response.body);
          double lastPrice = decodeData['rate'];
          cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        } else {
          print(response.statusCode);
          throw 'Problem with the get request';
        }
      }
      return cryptoPrices;
    } catch (e) {
      print(e);
    }
  }
}
