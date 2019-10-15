import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategoryProvide with ChangeNotifier{

  List<BxMallSubDto> childBxMallSubDto = [];

  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.comments = 'null';
    childBxMallSubDto = [all];
    childBxMallSubDto.addAll(list);
    notifyListeners();
  }

}