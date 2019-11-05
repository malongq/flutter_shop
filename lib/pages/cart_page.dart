import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';

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
            List infoList = Provide.value<CartProvide>(context).cartInfo;
            return ListView.builder(
              itemCount: infoList.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text('名称：  ${infoList[index].goodsName}'),
                  subtitle: Text('数量：${infoList[index].count}'),
                );
              },
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





