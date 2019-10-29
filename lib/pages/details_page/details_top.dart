import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';

//todo 商品详情头部区域
class DetailsTop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var goodInfo = Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo;
        if(goodInfo != null){
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodPic(goodInfo.image1),
                _goodName(goodInfo.goodsName),
                _goodNum(goodInfo.goodsSerialNumber),
                _goodPrice(goodInfo.presentPrice,goodInfo.oriPrice),
              ],
            ),
          );
        }else{
          return Text('正在加载中...');
        }
      },
    );
  }

  //商品图片
  Widget _goodPic(url){
    return Image.network(url,width: ScreenUtil().setWidth(750));
  }
  //商品名称
  Widget _goodName(name){
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(left: 15,top: 5),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Colors.black),
      ),
    );
  }
  //商品编号
  Widget _goodNum(num){
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(left: 15,top: 5),
      child: Text(
        '编号： ${num}',
        style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.black12),
      ),
    );
  }
  //商品价格
  Widget _goodPrice(price,oriPrice){
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(left: 15,top: 5),
      child: Row(
        children: <Widget>[
          Text(
            '¥ ${price}    ',
            style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.redAccent),
          ),
          Text(
            '市场价： ¥${oriPrice}',
            style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }

}
