import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Search extends StatelessWidget {
  String? searchQuery;
  Search({Key? key, this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: brandName(),
        elevation: 0,
      ),
    );
  }
}
