import 'package:ar_outdoor_furniture/model/item_model.dart';
import 'package:ar_outdoor_furniture/presentation/items_ui_design.dart';
import 'package:ar_outdoor_furniture/presentation/upload_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Outdoor Furniture Warehouse',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => UploadScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('items').orderBy('publisheddate', descending: true).snapshots(),
          builder: (context, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snap.hasError) {
              return Center(
                child: Text('Error: ${snap.error}'),
              );
            }
            if (snap.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snap.data.docs.length,
                  itemBuilder: (context, index) {
                    ItemModel items = ItemModel.fromMap(snap.data.docs[index].data() as Map<String, dynamic>);

                    return ItemsUi(
                      itemModel: items,
                    );
                  });
            }

            return Container(
              child: Center(child: Text('No Data.')),
            );
          },
        ));
  }
}
