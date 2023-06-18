import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../database/category_con.dart';
import '../../model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key, required this.screenType});
  String screenType;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
      appBar: AppBar(
        title: Text(widget.screenType),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categorys.length,
        itemBuilder: (context, index) => Padding(
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
                    await CategoryDB()
                        .deleteCategory(categorys[index].id)
                        .whenComplete(() => getCategoryData());
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
                  onPressed: (context) async {
                    await CategoryDB()
                        .updateCategory(CategoryModel(
                            id: categorys[index].id, name: 'Drink'))
                        .whenComplete(() => getCategoryData());
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
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/icons/conch-close.jpg'))),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        categorys[index].name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await CategoryDB()
              .insertCategory(
                CategoryModel(
                    id: DateTime.now().microsecondsSinceEpoch, name: 'Fish'),
              )
              .whenComplete(() => getCategoryData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
