import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:local_storage/view/home/view/product/pages/list_product_page.dart';

class FilterProductr extends StatefulWidget {
  FilterProductr({super.key, this.search});
  String? search;

  @override
  State<FilterProductr> createState() => _FilterProductrState();
}

class _FilterProductrState extends State<FilterProductr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.search != null ? 'Filter' : 'PROUCTS'),
      ),
      body: ListProductPage(search: widget.search),
    );
  }
}
