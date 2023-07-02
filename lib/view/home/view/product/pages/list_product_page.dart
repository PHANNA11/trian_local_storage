import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_storage/view/home/database/product_con.dart';
import 'package:local_storage/view/home/model/product_model.dart';
import 'package:local_storage/view/home/view/product/pages/update_product_page.dart';

class ListProductPage extends StatefulWidget {
  ListProductPage({super.key, this.search});
  String? search;

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  List<ProductModel> listProduct = [];
  getProductData() async {
    await ProductDB().getProduct().then((value) {
      setState(() {
        listProduct = value;
      });
    });
  }

  getFilterProductData() async {
    await ProductDB().filterProduct(widget.search).then((value) {
      setState(() {
        listProduct = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.search == null ? getProductData() : getFilterProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        listProduct.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: null,
              children: [
                SlidableAction(
                  padding: const EdgeInsets.all(8),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  onPressed: (context) async {
                    await ProductDB()
                        .deleteProduct(listProduct[index].id)
                        .whenComplete(() => getProductData());
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  onPressed: (context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateProduct(productModel: listProduct[index]),
                        ));
                  },
                  backgroundColor: const Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit_note_outlined,
                  label: 'Edit',
                ),
              ],
            ),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  FileImage(File(listProduct[index].image)))),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          listProduct[index].name,
                          // categorys[index].name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ ${listProduct[index].price}',
                          // categorys[index].name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          listProduct[index].rating.toStringAsFixed(1),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
