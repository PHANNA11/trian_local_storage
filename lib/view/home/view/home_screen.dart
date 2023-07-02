import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_storage/view/home/database/category_con.dart';
import 'package:local_storage/view/home/model/category_model.dart';
import 'package:local_storage/view/home/view/category/category_screen.dart';
import 'package:local_storage/view/home/view/product/crud_product_screen.dart';
import 'package:local_storage/view/home/view/product/pages/list_filter_product.dart';

import '../database/product_con.dart';
import '../model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categorys = [];
  getCategoryData() async {
    await CategoryDB().getCategory().then((value) {
      setState(() {
        categorys = value;
      });
    });
  }

  List<ProductModel> liistProduct = [];
  getProductData() async {
    await ProductDB().getProduct().then((value) {
      setState(() {
        liistProduct = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
    getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: 200,
                width: double.infinity,
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(screenType: 'Category'),
                        ));
                  },
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.rule,
                      size: 30,
                    ),
                  ),
                  title: const Text(
                    'Category',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CrudProductScreen(screenType: 'PRODUCT'),
                        ));
                  },
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.production_quantity_limits,
                      size: 30,
                    ),
                  ),
                  title: const Text(
                    'Product',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Local Shop'),
      ),
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              //   color: Colors.red,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorys.length,
                itemBuilder: (context, index) =>
                    buildCategory(categorys[index]),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Food',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterProductr(),
                            ));
                      },
                      child: Text(
                        'See All'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))
                ],
              )),
              Expanded(
                flex: 5,
                child: GridView.count(
                  primary: false,
                  shrinkWrap: false,
                  childAspectRatio: 12 / 20,
                  crossAxisCount: 2,
                  children: List.generate(liistProduct.length,
                      (index) => buildProductCard(pro: liistProduct[index])),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget buildProductCard({ProductModel? pro}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(pro!.image))),
          ),
          Positioned(
              bottom: 0,
              left: 20,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      pro.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Chip(
                      label: Text(
                        pro.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      avatar: const Icon(
                        Icons.star,
                        size: 20,
                        color: Color.fromARGB(255, 243, 110, 9),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget buildCategory(CategoryModel categoryModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FilterProductr(search: categoryModel.name),
              ));
        },
        child: Column(
          children: [
            Container(
              height: 70,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow,
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/icons/conch-close.jpg'))),
            ),
            Text(categoryModel.name),
          ],
        ),
      ),
    );
  }
}
