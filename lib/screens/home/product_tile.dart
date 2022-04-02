import 'package:flutter/material.dart';

import 'package:widgetmaster/models//product.dart';

class ProductTile extends StatelessWidget {
  int index;
  final String name;
  final int price;
  ProductTile(
      {required this.index,
      required this.name,
      required this.price}); //removed curly braces

  @override
  Widget build(BuildContext context) {
    void _showPurchasePanel(int index) {
      //this is a built in flutter widget fucntion
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                child: ElevatedButton(
                  onPressed: () {},
                  child:
                      Text('Pay amount $price for item $name of index $index'),
                ),
              ),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: InkWell(
          onTap: () {
            _showPurchasePanel(index);
          },
          child: ListTile(
              leading: CircleAvatar(
                //for a tile
                radius: 25.0,

                backgroundColor: Colors.brown[price],
                backgroundImage: AssetImage('images/image1.jpeg'),
              ), //whats on the left
              title: Text(name),
              subtitle: Text("Costs ${price} amount of dollars")),
        ),
      ),
    );
  }
}
