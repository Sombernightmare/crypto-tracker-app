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
  String bitcoinValue = '?';

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
    try {
      var data = await CoinInfo().getCoinData(selectedCurrency);
      setState(() {
        bitcoinValue = data.toString();
      });
    } catch (e) {
      print('hi');
    }
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
            Padding(
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
                    '1 BTC = $bitcoinValue $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffEEEEEE),
                    ),
                  ),
                ),
              ),
            ),
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
