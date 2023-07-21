import 'package:ar_outdoor_furniture/model/item_model.dart';
import 'package:ar_outdoor_furniture/presentation/ar_view.dart';
import 'package:flutter/material.dart';

class ItemsDetailedScreen extends StatefulWidget {
  final ItemModel itemModel;

  const ItemsDetailedScreen({required this.itemModel, Key? key}) : super(key: key);

  @override
  State<ItemsDetailedScreen> createState() => _ItemsDetailedScreenState();
}

class _ItemsDetailedScreenState extends State<ItemsDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemModel.itemName!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(widget.itemModel.itemUrl!),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(widget.itemModel.itemName!,
                    textAlign: TextAlign.justify, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.teal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(widget.itemModel.itemDesc!,
                    textAlign: TextAlign.justify, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('\$ ${widget.itemModel.itemprice!.toStringAsFixed(2)}',
                    textAlign: TextAlign.justify, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.teal)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.tealAccent,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ARView(
                        itemImageLink: widget.itemModel.itemUrl,
                      )));
        },
        label: Text('Try AR View'),
        icon: Icon(Icons.mobile_screen_share_rounded),
      ),
    );
  }
}
