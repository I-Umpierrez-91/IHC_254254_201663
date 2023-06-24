import 'package:flutter/material.dart';
import 'dart:typed_data';

class ImagePage extends StatelessWidget {
  final String id;
  final Uint8List imageItem;

  ImagePage({required this.imageItem, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Hero(
          tag: id,
          child: Image.memory(imageItem,
                                        width: 1000,
                                        height: 1000),
        ),
      ),
    );
  }
}
