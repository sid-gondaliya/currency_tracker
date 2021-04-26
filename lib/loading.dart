import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import './pricing.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './country&currency_data.dart';

class Loading extends StatefulWidget {
  final String countryvalue;
  Loading({this.countryvalue});
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Timer timer;
  double progress = 0;
  Map<String, String> prices = {};
  @override
  void initState() {
    super.initState();
    getpricing();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkprogress());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future getpricing() async {
    List countrykey = [];
    List pricekey = [];

    for (String i in cc.keys) {
      if (cc[i] == cc[widget.countryvalue]) {
        continue;
      }
      try {
        String url =
            'https://free.currconv.com/api/v7/convert?q=${cc[i]}_${cc[widget.countryvalue]}&compact=ultra&apiKey=YOUR API KEY';
        //ADD YOUR API KEY ABOVE
        var response = await http.get(url);
        //print(response.body);

        if (response.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(response.body);
          double fatchedprice =
              jsonResponse['${cc[i]}_${cc[widget.countryvalue]}'];
          prices[cc[i]] = fatchedprice.toStringAsFixed(3);
        }
      } catch (e) {
        print(e);
      }
    }
    countrykey = prices.keys.toList();
    pricekey = prices.values.toList();
    if (countrykey.isNotEmpty && pricekey.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Pricing(
            selectedcountry: widget.countryvalue,
            countries: countrykey,
            prices: pricekey,
          ),
        ),
      );
    }
    return;
  }

  void checkprogress() {
    setState(() {
      progress = prices.length.toDouble();
      progress = progress * 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please Wait',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'It takes 2-3 minutes',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 25,
            ),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              percent: progress / 100,
              center: new Text('$progress %'),
              progressColor: Colors.black,
              animation: true,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Loading',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
