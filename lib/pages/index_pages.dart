import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/current_index.dart';

class IndexPage extends StatelessWidget {

  final List<BottomNavigationBarItem> booTomTabs = [
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

  //保持页面状态如下
  final List<Widget> tabPage = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);//全局初始化屏幕适配
    return Provide<CurrentIndexProvide>(
      builder: (context,child,val){
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          body: Center(
            child: IndexedStack(
              index:currentIndex,
              children: tabPage,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white70,
            items: booTomTabs,
            currentIndex: currentIndex,
            onTap: (index){
              Provide.value<CurrentIndexProvide>(context).gotoWhere(index);
            },
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}


//class IndexPage extends StatefulWidget {
//  @override
//  _IndexPageState createState() => _IndexPageState();
//}
//
//class _IndexPageState extends State<IndexPage> {
//
//  final List<BottomNavigationBarItem> booTomTabs = [
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.home),
//      title: Text('首页')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.search),
//        title: Text('分类')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.shopping_cart),
//        title: Text('购物车')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.profile_circled),
//        title: Text('会员中心')
//    ),
//  ];
//
//  int currentIndex = 0;
//  var currentPage;
////  final List tabPage = [  改造保持页面状态如下
//  final List<Widget> tabPage = [
//    HomePage(),
//    CategoryPage(),
//    CartPage(),
//    MemberPage()
//  ];
//
//  @override
//  void initState() {
//    currentPage = tabPage[currentIndex];
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);//全局初始化屏幕适配
//
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//      body: Center(
////        child: currentPage, 改造保持页面状态如下
//        child: IndexedStack(
//          index:currentIndex,
//          children: tabPage,
//        ),
//      ),
//      bottomNavigationBar: BottomNavigationBar(
//        backgroundColor: Colors.white70,
//        items: booTomTabs,
//        currentIndex: currentIndex,
//        onTap: (index){
//          setState(() {
//            currentIndex = index;
//            currentPage = tabPage[currentIndex];
//          });
//        },
//        type: BottomNavigationBarType.fixed,
//      ),
//    );
//  }
//}



























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
