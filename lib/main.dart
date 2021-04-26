import './loading.dart';
import 'package:flutter/material.dart';
import './country&currency_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Tracker',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Currency Tracker')),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String country = 'Australia';

  List<DropdownMenuItem> getdropdownmenuitem() {
    List<DropdownMenuItem<String>> dropdownMenuItem = [];
    for (String i in countryList) {
      var item = DropdownMenuItem(
        child: Text(
          i,
        ),
        value: i,
      );
      dropdownMenuItem.add(item);
    }
    return dropdownMenuItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset('images/currency-vector.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 3),
            child: Center(
              child: Text(
                'Select Your Country',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2.0,
                    style: BorderStyle.solid,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            width: MediaQuery.of(context).size.width * 0.55,
            child: DropdownButton<String>(
                isExpanded: true,
                value: country,
                items: getdropdownmenuitem(),
                onChanged: (value) {
                  setState(() {
                    country = value;
                  });
                }),
          ),
          FlatButton(
            padding: EdgeInsets.all(18),
            shape: CircleBorder(
              side: BorderSide(
                style: BorderStyle.none,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Loading(
                    countryvalue: country,
                  ),
                ),
              );
            },
            color: Colors.black,
            child: Text(
              'Go',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
