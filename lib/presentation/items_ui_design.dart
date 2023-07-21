import 'package:ar_outdoor_furniture/model/item_model.dart';
import 'package:ar_outdoor_furniture/presentation/item_details_screen.dart';
import 'package:flutter/material.dart';

class ItemsUi extends StatefulWidget {
  final ItemModel? itemModel;

  const ItemsUi({this.itemModel, Key? key}) : super(key: key);

  @override
  State<ItemsUi> createState() => _ItemsUiState();
}

class _ItemsUiState extends State<ItemsUi> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ItemsDetailedScreen(itemModel: widget.itemModel!)));
      },
      splashColor: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(
                widget.itemModel!.itemUrl!,
                width: 140,
                height: 140,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Text(
                          widget.itemModel!.itemName!,
                          maxLines: 2,
                          style: const TextStyle(color: Colors.teal, fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.itemModel!.sellerName!,
                          maxLines: 2,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.teal,
                            ),
                            alignment: Alignment.topLeft,
                            width: 40,
                            height: 44,
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '50%',
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    'OFF',
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Original Price: \$ ',
                                    style: TextStyle(fontSize: 14, color: Colors.red, decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    (widget.itemModel!.itemprice! * 2).toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 15, color: Colors.red, decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Price: \$ ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    (widget.itemModel!.itemprice!).toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 4,
                        color: Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
