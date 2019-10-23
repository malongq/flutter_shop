import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategoryProvide with ChangeNotifier{

  List<BxMallSubDto> childBxMallSubDto = [];
  int childIndex = 0;//子类索引
  String catrgoryId = '4';
  String subId = '';
  int page = 1;//列表页数
  String noMoreText = '没有更多内容了...';

  //大类切换逻辑
  getChildCategory(List<BxMallSubDto> list,String id){
    page = 1;
    noMoreText = '';
    childIndex = 0;
    catrgoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.comments = 'null';
    childBxMallSubDto = [all];
    childBxMallSubDto.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  getChildRight(index,String id){
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  //下拉时候增加方法
  addPage(){
    page++;
  }

  //改变没有更多方法
  changeNomoreText(String text){
    noMoreText = text;
    notifyListeners();
  }

}