import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';
import 'package:flutter_html/flutter_html.dart';

//todo 商品详情web区域
class DetailsWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var goodInfo = Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo.goodsDetail;
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if(isLeft){
          if(goodInfo != null){
            return Container(
              child: Html(
                data: goodInfo,
              ),
            );
          }else{
            return Container(
              width: ScreenUtil().setWidth(750),
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text('暂无详情，请稍后...'),
            );
          }
        }else{
          return Container(
            width: ScreenUtil().setWidth(750),
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Text('暂无评价，请稍后...'),
          );
        }
      },
    );
  }

}
