import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';

//todo 商品详情底部区域
class DetailsBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var info = Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo;
    var goodsId = info.goodsId;
    var goodsName = info.goodsName;
    var count = 1;
    var price = info.presentPrice;
    var images = info.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){},
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(Icons.shopping_cart,size:35,color: Colors.red,),
            ),
          ),
          InkWell(
            onTap: ()async{
              await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text('加入购物车',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
          InkWell(
            onTap: ()async{
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text('立即购买',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}
