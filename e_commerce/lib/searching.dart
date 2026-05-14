import 'package:flutter/material.dart';

class Searching extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const Searching({super.key, required this.products});

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  void searchProduct(String query) {
    setState(() {
      filteredProducts = widget.products.where((product) {
        final name = product["name"].toString().toLowerCase();
        final description = product["description"].toString().toLowerCase();

        return name.contains(query.toLowerCase()) ||
            description.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Products")),

      body: Column(
        children: [
          // 🔥 SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(10),

            child: TextField(
              controller: searchController,

              onChanged: searchProduct,

              decoration: InputDecoration(
                hintText: "Search product...",
                prefixIcon: Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 🔥 RESULT LIST
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(child: Text("No Product Found"))
                : GridView.builder(
                    itemCount: filteredProducts.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),

                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.file(
                                filteredProducts[index]["image"],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredProducts[index]["name"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    filteredProducts[index]["description"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey),
                                  ),

                                  SizedBox(height: 6),

                                  Text(
                                    "৳ ${filteredProducts[index]["price"]}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}
