import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_storage/view/home/database/category_con.dart';
import 'package:local_storage/view/home/model/category_model.dart';
import 'package:local_storage/view/home/view/category/category_screen.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
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
                              CategoryScreen(screenType: 'Category'),
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
            child: Container(
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
                      onPressed: () {},
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
                  children: List.generate(10, (index) => buildProductCard()),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget buildProductCard() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://static.onecms.io/wp-content/uploads/sites/43/2023/01/30/70935-taqueria-style-tacos-mfs-3x2-35.jpg'))),
          ),
          Positioned(
              bottom: 0,
              left: 20,
              child: Container(
                height: 100,
                width: 100,
                child: Column(
                  children: const [
                    Text(
                      'Tuki Food',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Chip(
                      label: Text(
                        '5.0',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      avatar: Icon(
                        Icons.star,
                        size: 20,
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
    );
  }
}
