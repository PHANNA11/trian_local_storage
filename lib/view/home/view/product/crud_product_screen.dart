import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:local_storage/view/home/view/product/pages/add_product_page.dart';

import 'pages/list_product_page.dart';

class CrudProductScreen extends StatefulWidget {
  CrudProductScreen({super.key, this.screenType});
  String? screenType;
  @override
  State<CrudProductScreen> createState() => _CrudProductScreenState();
}

class _CrudProductScreenState extends State<CrudProductScreen> {
  List<Widget> pages = [ListProductPage(), AddProductPage()];
  int currentIndex = 0;
  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenType.toString()),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create')
        ],
        currentIndex: currentIndex,
        onTap: setIndex,
      ),
    );
  }
}
