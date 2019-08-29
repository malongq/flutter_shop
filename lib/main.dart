import 'package:flutter/material.dart';
import './pages/index_pages.dart';

void main()=>runApp(ShopApp());

class ShopApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}