import 'package:flutter/material.dart';
import '../model/detail_info.dart';
import '../service/service_request_manger.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{

  DetailsModel detailsModel = null;

  getDetailInfo(String id){
    var params = {'goodId' : id};
    getData('getGoodDetailById',params: params).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);
      detailsModel = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }


}