import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_request_manger.dart';
import 'dart:convert';
import '../model/category_model.dart';

//class CategoryPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: Text(
//          '分类'
//        ),
//      ),
//    );
//  }
//}

class CategoryPage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {

    _getCategory();

    return Container(
      child: Center(
        child: Text('分类'),
      ),
    );
  }

  void _getCategory() async{
    await getData('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category_data = CategoryModel.fromJson(data);
      print("分类页面数据：   "+data.toString());
      category_data.data[0].bxMallSubDto.forEach((item)=>print(item.mallSubName));
    });
  }

}

