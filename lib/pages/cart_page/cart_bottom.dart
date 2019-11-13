import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

// todo 购物车底部UI
class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _selectAll(context),
          _allPriceArea(context),
          _goBuy(context)
        ],
      ),
    );
  }

  //全选
  Widget _selectAll(context){
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val){},
          ),
          Text('全选'),
        ],
      ),
    );
  }

  //合计文案
  Widget _allPriceArea(context){
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        children: <Widget>[
          Provide<CartProvide>(
            builder: (context,child,val){
              var allPrice = Provide.value<CartProvide>(context).allPrice;
              return Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(280),
                    alignment: Alignment.centerRight,
                    child: Text('合计：',style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(150),
                    alignment: Alignment.centerLeft,
                    child: Text('¥  ${allPrice}',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.red),),
                  ),
                ],
              );
            },
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text('满10元免配送费，预购免配送费',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(22),color: Colors.black),),
          ),
        ],
      ),
    );
  }

  //结算
  Widget _goBuy(context){
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: (){},
        child: Provide<CartProvide>(
          builder: (context,child,val){
            var allCount = Provide.value<CartProvide>(context).allCount;
            return Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('结算(${allCount})',style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
            );
          }
        ),
      ),
    );
  }

}
