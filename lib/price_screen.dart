import 'package:flutter/material.dart';
import 'package:crypto_tracker_app/coin_info.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  List<DropdownMenuItem> getDropdownList() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];

      var item = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownList.add(item);
    }

    return dropDownList;
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
                  '1 BTC = ? USD',
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
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: getDropdownList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                  });
                }),
          ),
        ],
      ),
    );
  }
}
