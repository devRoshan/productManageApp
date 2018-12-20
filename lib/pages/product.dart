import 'dart:async';
import 'package:flutter/material.dart';

import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;

  ProductPage(this.title, this.price, this.imageUrl);

  _showWarningDialog(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Are you sure ?'),
          content: Text('This action can\'t be undone!'),
          actions: <Widget>[
            FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
              child: Text('CONTINUE'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
            )
          ]
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);

        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Product Detail'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/food.jpg'),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(title),
              ),
              _buildAddressPriceRow(),
              Container(
                padding: EdgeInsets.all(10.0),
                child: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => _showWarningDialog(context)
                ),
              )
            ],
          )
      )
    );
  }

  Widget _buildAddressPriceRow() {
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Maitidevi, Kathamandu, Nepal',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey)
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey)
          )
        ),
        Text(
          '\$' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
          )
      ]
    );
  }
}
