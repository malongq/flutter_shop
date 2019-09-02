import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> b = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        title: Text('分类')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: Text('购物车')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: Text('会员中心')
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('马龙'),),
      body: Center(
        child: Text('哈哈'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: b,backgroundColor: Colors.pink,),
    );
  }
}

//TODO 只是测试一下
//class IndexPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('百姓生活+'),),
//      body: Center(
//        child: Text('百姓生活+'),
//      ),
//    );
//  }
//}
