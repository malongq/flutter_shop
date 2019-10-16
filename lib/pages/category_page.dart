import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_request_manger.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/catrgory_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/child_category.dart';

//TODO 分类
class CategoryPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text('商品分类')),
      body: Container(
        child: Row(
          children: <Widget>[
            CategoryLeft(),
            Column(
              children: <Widget>[
                CategoryRight(),
                CategoryRightList(),
              ],
            )
          ],
        ),
      ),
    );
  }

}

//TODO 分类页面左侧导航
class CategoryLeft extends StatefulWidget {
  @override
  _CategoryLeftState createState() => _CategoryLeftState();
}

class _CategoryLeftState extends State<CategoryLeft> {

  List list = [];
  var listIndex = 0;

  //网络请求分类页面数据
  void _getCategory() async{
    await getData('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category_data = CategoryModel.fromJson(data);
      setState(() {
        list = category_data.data;
      });
      print("分类页面数据：   "+data.toString());
      //category_data.data[0].bxMallSubDto.forEach((item)=>print(item.mallSubName));
      Provide.value<ChildCategoryProvide>(context).getChildCategory(list[0].bxMallSubDto);
    });
  }

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border(
          right: BorderSide(color: Colors.black12,width: 1)
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _InkWellLeft(index);
        }
      ),
    );
  }

  Widget _InkWellLeft(int index){

    bool isChecked = false;
    isChecked = (index == listIndex) ? true : false;

    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategoryProvide>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10,top: 20),
        decoration: BoxDecoration(
          color: isChecked ? Colors.white70 : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12),
          ),
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.black),),
      )
    );
  }

}


//TODO 分类页面右侧导航
class CategoryRight extends StatefulWidget {
  @override
  _CategoryRightState createState() => _CategoryRightState();
}

class _CategoryRightState extends State<CategoryRight> {
  
//  List list = ['名酒','宝丰','北京二锅头','三贤醉','4贤醉','5贤醉','6贤醉','7贤醉','8贤醉','9贤醉','0贤醉'];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(100),
      width: ScreenUtil().setWidth(600),
      decoration: BoxDecoration(
        color: Colors.white,border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
      ),
      child: Provide<ChildCategoryProvide>(
        builder: (context,child,childCategory){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childBxMallSubDto.length,
            itemBuilder: (context,index){
              return _rightInkwell(childCategory.childBxMallSubDto[index]);
            }
          );
        }
      ),
    );
  }
  
  Widget _rightInkwell(BxMallSubDto item){
    return InkWell(
      onTap: (){},
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.black),
        ),
      ),
    );
  }
  
}


//TODO 分类页面右侧商品列表
class CategoryRightList extends StatefulWidget {
  @override
  _CategoryRightListState createState() => _CategoryRightListState();
}

class _CategoryRightListState extends State<CategoryRightList> {

  List list = [];

  @override
  void initState() {
    _getCategoryRightList();
    super.initState();
  }

  void _getCategoryRightList()async{
    var dataParams = {
      'categoryId' : '4',
      'CategorySubId' : "",
      'page' : 1,
    };
    await getData('getMallGoods',params: dataParams).then((val){
      var dataList = json.decode(val.toString());
      print("分类页面列表数据：   "+dataList.toString());
      CategoryListModel categoryListModel = CategoryListModel.fromJson(dataList);
      setState(() {
        list = categoryListModel.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(600),
      height: ScreenUtil().setHeight(980),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder:(context,index){
          return _ListItem(index);
        }
      ),
    );
  }

  //图片组件
  Widget _image(index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  //名称组件
  Widget _title(index){
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(400),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.black),
      ),
    );
  }

  //价钱组件
  Widget _price(index){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(400),
      child: Row(
        children: <Widget>[
          Text('价格： ¥${list[index].presentPrice}  ',style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(30))),
          Text('¥${list[index].oriPrice}',style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),)
        ],
      ),
    );
  }

  //组合 图片+名称+价钱 三个组件
  Widget _ListItem(index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.black12,width: 1)
          )
        ),
        child: Row(
          children: <Widget>[
            _image(index),
            Column(
              children: <Widget>[
                _title(index),
                _price(index),
              ],
            )
          ],
        ),
      ),
    );
  }

}







