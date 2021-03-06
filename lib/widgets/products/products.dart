import 'package:flutter/material.dart';

import './Product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _buildProductList() {
    Widget productCards = Container();

    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    }

    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
