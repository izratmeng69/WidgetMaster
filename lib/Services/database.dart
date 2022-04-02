import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:widgetmaster/models/product.dart';

import '../models/currentuser.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  DatabaseService.withoutUID() : uid = "";

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');
  //'orders collectio  nwill be created if it doesnt already exists

//adding user data to bakery app

  Future updateUserData(String name, int price) async {
    return await orderCollection.doc(uid).set({
      'name': name,
      'price': price,
    }); //will create if doesnt exist
  }

  Stream<QuerySnapshot?> get snap {
    //snapshot of orders
    return orderCollection.snapshots();
  } //old stream returning snapshot-unused

  Stream<List<Product>> get orders {
    return orderCollection.snapshots().map(_productListFromSnapshot);
  }

//return list of products
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    /* List<Product> products = [];
    snapshot.docs.forEach((element) {
      products.add(Product(element.get('name'), element.get('price')));
    });
    return products;
  }*/
    return snapshot.docs
        .map((e) => Product(e.get('name'), e.get('price')))
        .toList();
  }

  Stream<UserData> get userData {
    return orderCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  } //listenedin form

  //useradata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid!,
      name: snapshot.get('name'),
      price: snapshot.get('price'),
    );
  }
}
