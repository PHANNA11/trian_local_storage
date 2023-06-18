import 'package:local_storage/global/constant/global.dart';

class ProductModel {
  late int id;
  late String name;
  late String image;
  late String category;
  late double rating;
  late double price;
  ProductModel(
      {required this.category,
      required this.id,
      required this.image,
      required this.name,
      required this.rating,
      required this.price});
  Map<String, dynamic> toMap() {
    return {
      fProId: id,
      fProName: name,
      fProImage: image,
      fProPrice: price,
      fProCategory: category,
      fProRating: rating
    };
  }

  ProductModel.fromJson(Map<String, dynamic> res)
      : category = res[fProCategory],
        id = res[fProId],
        image = res[fProImage],
        name = res[fProName],
        rating = res[fProRating],
        price = res[fProPrice];
}
