import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategoryProvide with ChangeNotifier{

  List<BxMallSubDto> childBxMallSubDto = [];
  int childIndex = 0;//子类索引
  String catrgoryId = '4';
  String subId = '';

  //大类切换逻辑
  getChildCategory(List<BxMallSubDto> list,String id){
    childIndex = 0;
    catrgoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.comments = 'null';
    childBxMallSubDto = [all];
    childBxMallSubDto.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  getChildRight(index,String id){
    childIndex = index;
    subId = id;
    notifyListeners();
  }

}