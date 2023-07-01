import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_storage/view/home/database/product_con.dart';
import 'package:local_storage/view/home/model/product_model.dart';

import '../../../database/category_con.dart';
import '../../../model/category_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<CategoryModel> categorys = [];
  getCategoryData() async {
    await CategoryDB().getCategory().then((value) {
      setState(() {
        categorys = value;
      });
    });
  }

  File? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
  }

  TextEditingController selectCategoryntroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  // TextEditingController qtyController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  CategoryModel? categoryModel;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Product name'),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextField(
        //     controller: qtyController,
        //     decoration: const InputDecoration(
        //         border: OutlineInputBorder(), hintText: 'Product Qty'),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: priceController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Product Price\$'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: rateController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Rate value'),
          ),
        ),
        Wrap(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Card(
                elevation: 0,
                child: Row(
                  children: [
                    const Expanded(
                        flex: 3,
                        child: Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                    Expanded(
                      flex: 6,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<CategoryModel>(
                          isExpanded: true,
                          dropdownSearchData: DropdownSearchData(
                            searchController: selectCategoryntroller,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 60,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: selectCategoryntroller,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'select',
                                  // hintStyle: hintTextStyle,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return (item.value!.name
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase()));
                            },
                          ),
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              selectCategoryntroller.clear();
                            }
                          },
                          hint: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  'select Category',
                                  style: TextStyle(
                                    //  fontSize: BodyTextSize,
                                    fontWeight: FontWeight.bold,
                                    //  color: Colors.yellow,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: categorys
                              .map((brand) => DropdownMenuItem<CategoryModel>(
                                    value: brand,
                                    child: Text(
                                      brand.name.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        //  color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: categoryModel,
                          onChanged: (value) {
                            setState(() {
                              categoryModel = value;
                              dev.log(value.toString());
                              selectCategoryntroller.text = categoryModel!.name;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 50,
                            width: 400,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              // color: Colors.redAccent,
                            ),
                            //elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            isFullScreen: true,
                            maxHeight: 250,
                            width: 250,
                            padding: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              //   color: Colors.redAccent,
                            ),
                            //elevation: 8,
                            offset: const Offset(0, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(10),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 1)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: image == null
                        ? Center(
                            child: Icon(
                              Icons.image_rounded,
                              size: 50,
                              color: Colors.grey,
                            ),
                          )
                        : Image(image: FileImage(File(image!.path))),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 50,
                right: 50,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Image'),
                        content: Flexible(
                            child: Text('Choose Image to set Product')),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              cameraImage();
                            },
                            child: Text('Camera'),
                          ),
                          MaterialButton(
                            onPressed: () {
                              gallaryImage();
                            },
                            child: Text('Gallary'),
                          )
                        ],
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey)),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              await ProductDB().insertProduct(ProductModel(
                  category: categoryModel!.name,
                  id: DateTime.now().microsecondsSinceEpoch,
                  image: image!.path,
                  name: nameController.text,
                  rating: double.parse(rateController.text),
                  price: double.parse(priceController.text)));
            },
            child: Container(
              height: 60,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            ),
          ),
        )
      ],
    );
  }

  void gallaryImage() async {
    var imageSource =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imageSource!.path);
    });
    if (image != null) {
      Navigator.pop(context);
    }
  }

  void cameraImage() async {
    var imageSource = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      image = File(imageSource!.path);
    });
    if (image != null) {
      Navigator.pop(context);
    }
  }
}
