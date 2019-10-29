import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//todo 商品详情说明区域
class DetailsExplan extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(left:15,top: 10),
      padding: EdgeInsets.all(8),
      child:Text(
        '说明： >  急速送达  >  正品保证',
        style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.red),
      ),
    );
  }

}
