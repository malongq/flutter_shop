import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';
import '../pages/map_page.dart';

//todo 商品详情页面路由
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('index gooodId is ${goodsId}');
    return DetailsPage(goodsId);
  }
);


//todo 高德地图页面路由
Handler mapHandler = Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return MapPage();
    }
);