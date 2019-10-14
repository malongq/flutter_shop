import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_request_manger.dart';
import 'dart:convert';
import '../model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            CategoryLeft()
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
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10,top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12),
          ),
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: 17,color: Colors.black),),
      )
    );
  }

}


