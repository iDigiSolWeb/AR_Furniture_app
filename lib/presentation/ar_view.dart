import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';

class ARView extends StatefulWidget {
  final itemImageLink;
  const ARView({this.itemImageLink, Key? key}) : super(key: key);

  @override
  State<ARView> createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  @override
  Widget build(BuildContext context) {
    return AugmentedRealityPlugin(widget.itemImageLink);
  }
}
