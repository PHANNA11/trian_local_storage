import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_storage/view/home/database/category_con.dart';
import 'package:local_storage/view/home/model/category_model.dart';

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
      appBar: AppBar(
        title: Text('Welcome back'),
      ),
      body: ListView.builder(
        itemCount: categorys.length,
        itemBuilder: (context, index) => Card(
            child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: null,
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await CategoryDB()
                      .deleteCategory(categorys[index].id)
                      .whenComplete(() => getCategoryData());
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (context) async {
                  await CategoryDB()
                      .updateCategory(
                          CategoryModel(id: categorys[index].id, name: 'Drink'))
                      .whenComplete(() => getCategoryData());
                },
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit_note_outlined,
                label: 'Edit',
              ),
            ],
          ),
          child: ListTile(
            title: Text(categorys[index].name),
          ),
        )),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
