import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';

//todo 商品详情自定义 评价/详情 UI
class DratilsTabbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        var isRight = Provide.value<DetailsInfoProvide>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _left(context, isLeft),
                  _right(context, isRight),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  //点击左侧
  Widget _left(BuildContext context,bool isLeft){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvide>(context).getTabbarChange('left');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: isLeft ? Colors.pink : Colors.black12,
              width: 1
            )
          )
        ),
        child: Text(
          '详细',style: TextStyle(color: isLeft ? Colors.pink : Colors.black12,fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  //点击右侧
  Widget _right(BuildContext context,bool isRight){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvide>(context).getTabbarChange('right');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    color: isRight ? Colors.pink : Colors.black12,
                    width: 1
                )
            )
        ),
        child: Text(
          '评论',style: TextStyle(color: isRight ? Colors.pink : Colors.black12,fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}

