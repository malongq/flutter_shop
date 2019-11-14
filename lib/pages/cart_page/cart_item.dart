import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

//todo 购物车页面条目模块
class CartItem extends StatelessWidget {

  final CartInfoModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          _checkBox(context,item),
          _image(item),
          _title(item),
          _price(item,context)
        ],
      ),
    );
  }

  //复选框
  Widget _checkBox(context,item){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        onChanged: (bool val){
          item.isCheck = val;
          Provide.value<CartProvide>(context).checkGoods(item);
        },
        activeColor: Colors.red,
      ),
    );
  }

  //图片
  Widget _image(item){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }

  //名称
  Widget _title(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  Widget _price(item,context){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${item.price}'),
          Container(
            child: InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).removeInfo(item.goodsId);
              },
              child: Icon(Icons.delete_forever,color: Colors.black26,),
            ),
          )
        ],
      ),
    );
  }


}
