import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import '../pages/cart_page/cart_item.dart';
import '../pages/cart_page/cart_bottom.dart';

//todo 购物车页面
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车'),),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context,child,val){
                    List infoList = Provide.value<CartProvide>(context).cartInfo;
                    return ListView.builder(
                        itemCount: infoList.length,
                        itemBuilder: (context,index){
                          return CartItem(infoList[index]);
                        }
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child:CartBottom()
                ),
              ],
            );
          }else{
            return Text('暂无数据');
          }
        },
      ),
    );
  }

  //查询购物车内添加的商品明细
  Future<String> _getCartInfo(BuildContext context)async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }

}





