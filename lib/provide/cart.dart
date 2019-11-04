import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//todo 详情页购物车添加删除逻辑类
class CartProvide with ChangeNotifier{
  String cartString  = '[]';

  save (goodsId,goodsName,count,price,images)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cart_info');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int i = 0;
    tempList.forEach((item){
      if(item['goodsId']==goodsId){
        tempList[i]['count'] = item['count'] + 1;
        isHave = true;
      }
      i++;
    });

    if(!isHave){
      tempList.add({
        'goodsId' : goodsId,
        'goodsName' : goodsName,
        'count' : count,
        'price' : price,
        'images' : images,
      });
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    sp.setString('cart_info', cartString);
    notifyListeners();

  }

  remove()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cart_info');
    print('清空完成。。。。。。。。。。。');
    notifyListeners();
  }

}