import 'package:flutter/material.dart';
import './country&currency_data.dart';

class Pricing extends StatefulWidget {
  final String selectedcountry;
  final List countries;
  final List prices;

  Pricing({this.countries, this.prices, this.selectedcountry});
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  Card getcard(String country, String price) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(top: 12),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.075,
            child: Text(
              '1  $country',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.075,
            child: Text(
              ':',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.075,
            child: Text(
              '$price  ${cc[widget.selectedcountry]}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> index = [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Tracker'),
      ),
      body: ListView(
        children: [
          for (var i in index) getcard(widget.countries[i], widget.prices[i]),
        ],
      ),
    );
  }
}
