import 'package:local_storage/global/constant/global.dart';

class CategoryModel {
  late int id;
  late String name;
  CategoryModel({required this.id, required this.name});
  Map<String, dynamic> toMap() {
    return {fCategoryId: id, fCategoryName: name};
  }

  CategoryModel.fromMap(Map<String, dynamic> res)
      : id = res[fCategoryId],
        name = res[fCategoryName];
}
