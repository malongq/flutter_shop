import 'package:flutter/material.dart';
import '../model/detail_info.dart';
import '../service/service_request_manger.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{

  DetailsModel detailsModel = null;
  bool isLeft = true;
  bool isRight = false;

  //获取商品详情信息
  getDetailInfo(String id){
    var params = {'goodId' : id};
    getData('getGoodDetailById',params: params).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);
      detailsModel = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  //更改点击评价，详情状态
  getTabbarChange(String change){
    if(change == 'left'){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

}