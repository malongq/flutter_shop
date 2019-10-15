import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_request_manger.dart';
import 'dart:convert';
import '../model/category_model.dart';
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
              ],
            )
          ],
        ),
      ),
    );
  }

}

//分类页面左侧导航
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


//分类页面右侧导航
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



