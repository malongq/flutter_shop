import 'package:flutter/material.dart';
import './pages/index_pages.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:flutter_shop/provide/child_category.dart';

void main(){
  var counter = Counter();
  var childCategoryProvide = ChildCategoryProvide();
  var provides = Providers();
  provides
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<ChildCategoryProvide>.value(childCategoryProvide));
  runApp(ProviderNode(child: ShopApp(), providers: provides));
}

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