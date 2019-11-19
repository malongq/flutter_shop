import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/roiter_handler.dart';

class Routess{

  static String root = '/';
  static String detailsPage = '/detail';
  static String mapPage = '/map';

  static void configreRoutes(Router router){

    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('Error=====>router is not found');
      }
    );

    router.define(detailsPage, handler: detailsHandler);
    router.define(mapPage, handler: mapHandler);
  }

}