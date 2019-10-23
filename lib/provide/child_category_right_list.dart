import 'package:flutter/material.dart';
import 'package:flutter_shop/model/catrgory_list_model.dart';

class ChildCategoryRightListProvide with ChangeNotifier{

  List<CategoryListModelData> childList = [];

  getChildCategoryRightList(List<CategoryListModelData> list){
    childList = list;
    notifyListeners();
  }

  getChildCategoryRightList2(List<CategoryListModelData> list){
    childList.addAll(list);
    notifyListeners();
  }

}