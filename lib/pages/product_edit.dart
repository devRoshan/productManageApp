import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;

  ProductEditPage({this.addProduct, this.updateProduct, this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  String _titleValue;
  String _descriptionValue;
  double _priceValue;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildProductTitleTextField(),
              _buildProductDescriptionTextField(),
              _buildProductPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: _submitForm
              )
            ],
          )
        ) 
      ),
    );

    return widget.product == null 
      ? pageContent
      : Scaffold(
        appBar: AppBar(
          title: Text('Edit Product')
        )
      );
  }

  Widget _buildProductTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product title'
      ),
      initialValue: widget.product == null ? '' : widget.product['title'],
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildProductDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product description'
      ),
      initialValue: widget.product == null ? '' : widget.product['description'],
      maxLines: 4,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Title is required and should be 10+ characters long';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildProductPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product price'
      ),
      initialValue: widget.product == null ? '' : widget.product['price'].toString(),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a valid number';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    widget.addProduct(_formData);

    Navigator.pushReplacementNamed(context, '/products');
  }
}
