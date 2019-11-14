import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/cart.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/model/cart_info.dart';

//TODO 购物车页面自定义加减布局
class CartCount extends StatelessWidget {

  final CartInfoModel item;
  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _centerShow(context),
          _addBtn(context)
        ],
      ),
    );
  }

  //减少按钮
  Widget _reduceBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduce(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        child: Text('-'),
        decoration: BoxDecoration(
          color: item.count>1?Colors.white:Colors.grey,
          border: Border(
            right: BorderSide(
              width: 1,color: Colors.black12
            )
          )
        ),
      ),
    );
  }

  //中间展示数量
  Widget _centerShow(context){
    return Container(
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        color: Colors.white,
        child: Text('${item.count}'),
    );
  }

  //增加按钮
  Widget _addBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduce(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        child: Text('+'),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(
                    width: 1,color: Colors.black12
                )
            )
        ),
      ),
    );
  }

}
