import 'package:flutter/material.dart';
import './pages/index_pages.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/child_category_right_list.dart';
import 'package:fluro/fluro.dart';
import 'routers/routers.dart';
import 'routers/application.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/current_index.dart';

void main(){
  var counter = Counter();
  var childCategoryProvide = ChildCategoryProvide();
  var childCategoryRightListProvide = ChildCategoryRightListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var provides = Providers();
  provides
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<ChildCategoryProvide>.value(childCategoryProvide))
  ..provide(Provider<ChildCategoryRightListProvide>.value(childCategoryRightListProvide))
  ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
  ..provide(Provider<CartProvide>.value(cartProvide))
  ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(child: ShopApp(), providers: provides));
}

class ShopApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routess.configreRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}