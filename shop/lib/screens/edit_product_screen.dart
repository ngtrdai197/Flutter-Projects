import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();

  Product _editProduct = Product(
    id: DateTime.now().toString(),
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm(ProductsProvider productProvider) {
    final state = _formKey.currentState;
    if (state == null) {
      return;
    }
    final isValid = state.validate();
    if (!isValid) {
      return;
    }
    state.save();
    print('Save form ${_editProduct.title}');
    print('Save form ${_editProduct.description}');
    print('Save form ${_editProduct.price}');
    print('Save form ${_editProduct.imageUrl}');
    productProvider.updateProduct(_editProduct);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onChanged: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    title: value,
                    price: _editProduct.price,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onChanged: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    title: _editProduct.title,
                    price: double.parse(value),
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (value.contains(',')) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
                onChanged: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    title: _editProduct.title,
                    price: _editProduct.price,
                    description: value,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onChanged: (value) {
                        _editProduct = Product(
                          id: _editProduct.id,
                          title: _editProduct.title,
                          price: _editProduct.price,
                          description: _editProduct.description,
                          imageUrl:
                              value.isEmpty ? _imageUrlController.text : value,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  _saveForm(productProvider);
                },
              )
            ],
          ),
        ));
  }
}
