import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:widgetmaster/screens/home/product_tile.dart';
import 'package:widgetmaster/models/product.dart';

class ProductsList extends StatefulWidget {
  //const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(
        context); //?? [];my null check game me an error
    if (products == [])
      return (Text("Failed to receive products list"));
    else {
      int counter = 0;
      for (var prod in products) {
        //deconstructing and reading product objects
        counter++;
        String name = prod.name;
        int price = prod.price;
        //print(name);
        // print(price);
      }

      return Expanded(
          //expandedMUST ALWAYS COMEBEFORE ALOIST VIEW BUILDER
          child: ListView.builder(
              itemCount: counter,
              itemBuilder: (context, index) {
                var prod = products[index]; //do not messs with this
                return ProductTile(
                    index: index,
                    name: prod.name,
                    price: prod
                        .price); //couldnt use product object,so i used thedata instead
              }));

      //return Card(color: Colors.red, child: Text(products.toString()));
    }
  }
}
