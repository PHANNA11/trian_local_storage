import 'package:flutter/material.dart';
import 'package:local_storage/view/home/model/product_model.dart';
import 'package:local_storage/view/home/view/product/pages/add_product_page.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({super.key, this.productModel});
  ProductModel? productModel;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: AddProductPage(product: widget.productModel),
    );
  }
}
