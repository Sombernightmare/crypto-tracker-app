import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAvgURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinInfo {
  Future getCoinData(String currency) async {
    String url = '$coinAvgURL/BTC$currency';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      double lastPrice = decodeData['last'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with get request';
    }
  }
}
