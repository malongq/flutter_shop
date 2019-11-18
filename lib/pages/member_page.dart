import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//todo 我的页面
class MemberPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('会员中心'),),
      body: Container(
        child: ListView(
          children: <Widget>[
            _topHeader(),
            _orderTitle(),
            _orderType(),
            _actionList()
          ],
        ),
      ),
    );
  }

  //头像区域
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.only(top: 20),
            child: ClipOval(
              child: Image.network('http://img.hao661.com/qq.hao661.com/uploads/allimg/c160128/1453c259451560-121426.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('马龙',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Colors.white),),
          )
        ],
      ),
    );
  }
  
  //我的订单顶部区域
  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
  
  //我的订单类型区域
  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(125),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(750/4),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode,size: 30,),
                Text('待付款')
              ],
            ),
          ),
          //--------------------------//
          Container(
            width: ScreenUtil().setWidth(750/4),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder,size: 30,),
                Text('待发货')
              ],
            ),
          ),
          //--------------------------//
          Container(
            width: ScreenUtil().setWidth(750/4),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car,size: 30,),
                Text('待收货')
              ],
            ),
          ),
          //--------------------------//
          Container(
            width: ScreenUtil().setWidth(750/4),
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste,size: 30,),
                Text('待评价')
              ],
            ),
          ),
          //--------------------------//
        ],
      ),
    );
  }

  //活动区域
  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _list('领取优惠券'),
          _list('地址管理'),
          _list('客服电话'),
          _list('关于我们'),
          _list('投诉建议'),
        ],
      ),
    );
  }

  //下方列表子元素
  Widget _list(String title){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1,color: Colors.black12)
          )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

}







//class MemberPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.all(20),
//      child: Provide<Counter>(
//          builder: (context,child,counter){
//            return Text('${counter.value}');
//          }
//      ),
//    );
//  }
//}
//
//
//class Num extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.all(20),
//      child: Provide<Counter>(
//          builder: (context,child,counter){
//            return Text('${counter.value}');
//          }
//      ),
//    );
//  }
//}