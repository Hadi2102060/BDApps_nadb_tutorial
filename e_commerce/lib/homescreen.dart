import 'dart:io';

import 'package:e_commerce/searching.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  List<Map<String, dynamic>> products = [];
  File? selectedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        imageController.text = image.path;
      });
    }
  }

  void addProduct() {
    Map<String, dynamic> newProduct = {
      "name": productNameController.text,
      "description": productDescriptionController.text,
      "price": int.tryParse(productPriceController.text) ?? 0,
      "image": selectedImage,
    };

    setState(() {
      products.add(newProduct);
    });

    productNameController.clear();
    productDescriptionController.clear();
    productPriceController.clear();
    imageController.clear();
    selectedImage = null;

    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          " Home Screen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Searching(products: products),
                ),
              );
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 15),
              TextFormField(
                controller: productNameController,

                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.blue,
                  ),
                  labelText: "Enter your Product Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: productDescriptionController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.description_outlined,
                    color: Colors.green,
                  ),
                  labelText: "product description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 15),
              TextFormField(
                controller: productPriceController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.attach_money, color: Colors.amber),
                  labelText: "Product Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: imageController,
                readOnly: true,

                onTap: pickImage,

                decoration: InputDecoration(
                  labelText: "Select Product Image",

                  border: OutlineInputBorder(),

                  prefixIcon: Icon(Icons.image),

                  suffixIcon: Icon(Icons.upload),
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(onPressed: addProduct, child: Text("Product Add")),
              SizedBox(height: 20),
              Text(
                "Explore our products and enjoy shopping!",
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 20),

              GridView.builder(
                itemCount: products.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: products[index]["image"] != null
                              ? Image.file(
                                  products[index]["image"],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image, size: 40),
                                ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              Text(
                                products[index]["name"] ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                products[index]["description"] ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),

                              SizedBox(height: 6),

                              Text(
                                "৳ ${products[index]["price"] ?? 0}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
