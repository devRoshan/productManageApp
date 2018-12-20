import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/product.dart';
import './pages/products.dart';

main () {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
        accentColor: Colors.deepPurple,
        buttonColor: Colors.deepPurple
      ),
      routes: {
        '/': (BuildContext build) => AuthPage(),
        '/products': (BuildContext build) => ProductsPage(_products),
        '/admin': (BuildContext build) => ProductsAdminPage(_addProduct, _deleteProduct, _products),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');

        if (pathElements[0] != '') {
          return null;
        }

        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);

          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(_products[index]['title'], _products[index]['price'], _products[index]['image'])
          );
        }

        return null;
      },

      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext build) =>
            ProductsPage(_products)
        );
      }
    );
  }
}
