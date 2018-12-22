import 'package:flutter/material.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index]['title']),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              this.debugDescribeChildren();
            } else if (direction == DismissDirection.startToEnd) {
              print('Start to end');
            } else {
              print('other swiping direction');
            }
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage(products[index]['image'])),
                title: Text(products[index]['title']),
                subtitle: Text('\$${products[index]['price']}'),
                trailing: _buildEditButton(context, index)
              ),
              Divider()  
            ]
          )
        );
      },
      itemCount: products.length,
    );
  }

  Widget _buildEditButton(BuildContext context, index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage(
                product: products[index],
                updateProduct: updateProduct, 
                productIndex: index
              );
            }
          )
        );
      },
    );
  }
}
