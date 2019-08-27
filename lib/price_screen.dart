import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:crypto_tracker_app/coin_info.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  Map<String, String> coinValues = {};
  bool isWaiting = false;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];

      var item = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownList.add(item);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownList,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData();
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }

    return CupertinoPicker(
        backgroundColor: Color(0xff00adb5),
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        },
        children: items);
  }

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinInfo().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print('hi');
    }
  }

  Column createCard() {
    List<CoinCard> coinCards = [];

    for (String coin in cryptoList) {
      coinCards.add(CoinCard(
          coin: coin,
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[coin]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: coinCards,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Ticker'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            createCard(),
            Container(
                height: 150,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30),
                color: Color(0xff00adb5),
                child: Platform.isAndroid ? androidDropdown() : iosPicker()),
          ]),
    );
  }
}

class CoinCard extends StatelessWidget {
  const CoinCard({this.coin, this.selectedCurrency, this.value});

  final String coin;
  final String selectedCurrency;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Card(
        color: Color(0xff00adb5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          child: Text(
            '1 $coin = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xffEEEEEE),
            ),
          ),
        ),
      ),
    );
  }
}
