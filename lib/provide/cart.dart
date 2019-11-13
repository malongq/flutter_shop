import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_shop/model/cart_info.dart';

//todo 详情页购物车添加删除逻辑类
class CartProvide with ChangeNotifier{
  String cartString  = '[]';
  List<CartInfoModel> cartInfo = [];
  double allPrice = 0;
  int allCount = 0;
  bool isAllCheck = true;

  //添加商品方法
  save (goodsId,goodsName,count,price,images)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cart_info');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int i = 0;
//    allPrice = 0;
//    allCount = 0;
    tempList.forEach((item){
      if(item['goodsId']==goodsId){
        tempList[i]['count'] = item['count'] + 1;
        cartInfo[i].count++;
        isHave = true;
      }
//      if(item['isCheck']){
//        allPrice += (cartInfo[i].price * cartInfo[i].count);
//        allCount += cartInfo[i].count;
//      }
      i++;
    });

    if(!isHave){
      Map<String,dynamic> newGoods={
        'goodsId' : goodsId,
        'goodsName' : goodsName,
        'count' : count,
        'price' : price,
        'images' : images,
        'isCheck' : true,
      };
      tempList.add(newGoods);
      cartInfo.add(CartInfoModel.fromJson(newGoods));
//      allPrice += (count * price);
//      allCount + count;
    }

    cartString = json.encode(tempList).toString();
    print('字符串：  ${cartString}');
    print('集合： ${cartInfo}');
    sp.setString('cart_info', cartString);
    notifyListeners();

  }


  //清空商品方法
  remove()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cart_info');
    cartInfo = [];
//    allPrice = 0;
//    allCount = 0;
    print('清空完成。。。。。。。。。。。');
    notifyListeners();
  }


  //获取所有商品方法
  getCartInfo()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cart_info');
    cartInfo = [];

    if(cartString == null){
      cartInfo = [];
    }else{
      List<Map> tempList = (json.decode(cartString.toString())as List).cast();
      allPrice = 0;
      allCount = 0;
      isAllCheck = true;
      tempList.forEach((item){
        if(item['isCheck']){
          allPrice += (item['count'] * item['price']);
          allCount += item['count'];
        }else{
          isAllCheck = false;
        }
        cartInfo.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }


  //删除单个商品方法
  removeInfo(String goodId)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cart_info');
    List<Map> list = (json.decode(cartString.toString())as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    list.forEach((item){
      if(item['goodsId'] == goodId){
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    list.removeAt(delIndex);
    cartString = json.encode(list).toString();
    sp.setString('cart_info', cartString);
    await getCartInfo();
  }


  //选中单个商品方法
  checkGoods(CartInfoModel cartInfoModel)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cart_info');
    List<Map> list = (json.decode(cartString.toString())as List).cast();
    int temIndex = 0;
    int checkIndex = 0;
    list.forEach((item){
      if(item['goodsId'] == cartInfoModel.goodsId){
        checkIndex = temIndex;
      }
      temIndex++;
    });
    list[checkIndex] = cartInfoModel.toJson();
    cartString = json.encode(list).toString();
    sp.setString('cart_info', cartString);
    await getCartInfo();
  }


  //全选所有商品方法
  allCheck(bool isCheck)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cart_info');
    List<Map> list = (json.decode(cartString.toString())as List).cast();
    List<Map> newList = [];
    for(var item in list){
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    sp.setString('cart_info', cartString);
    await getCartInfo();
  }

}