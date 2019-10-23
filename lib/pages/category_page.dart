import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_request_manger.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/catrgory_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/child_category_right_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      Provide.value<ChildCategoryProvide>(context).getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
    });
  }

  void _getCategoryRightList({String catrgoryId})async{
    var dataParams = {
      'categoryId' : catrgoryId == null ? '4' : catrgoryId,
      'categorySubId' : "",
      'page' : 1,
    };
    await getData('getMallGoods',params: dataParams).then((val){
      var dataList = json.decode(val.toString());
      print("dataParams左侧：   "+dataParams.toString());
      CategoryListModel categoryListModel = CategoryListModel.fromJson(dataList);
      Provide.value<ChildCategoryRightListProvide>(context).getChildCategoryRightList(categoryListModel.data);
    });
  }

  @override
  void initState() {
    _getCategory();
    _getCategoryRightList();
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
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategoryProvide>(context).getChildCategory(childList,categoryId);
        _getCategoryRightList(catrgoryId: categoryId);
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
              return _rightInkwell(index, childCategory.childBxMallSubDto[index]);
            }
          );
        }
      ),
    );
  }
  
  Widget _rightInkwell(int index, BxMallSubDto item){

    bool isClick = false;
    isClick = (index==Provide.value<ChildCategoryProvide>(context).childIndex) ? true : false;

    return InkWell(
      onTap: (){
        Provide.value<ChildCategoryProvide>(context).getChildRight(index,item.mallCategoryId);
        _getCategoryRightList2(item.mallSubId);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(30),color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  void _getCategoryRightList2(String categorySubId)async{
    var dataParams = {
      'categoryId' : Provide.value<ChildCategoryProvide>(context).catrgoryId,
      'categorySubId' : categorySubId,
      'page' : 1,
    };
    await getData('getMallGoods',params: dataParams).then((val){
      print("dataParams：   "+dataParams.toString());
      var dataList = json.decode(val.toString());
      CategoryListModel categoryListModel = CategoryListModel.fromJson(dataList);
      if(categoryListModel.data == null){
        Provide.value<ChildCategoryRightListProvide>(context).getChildCategoryRightList([]);
      }else{
        Provide.value<ChildCategoryRightListProvide>(context).getChildCategoryRightList(categoryListModel.data);
      }
    });
  }
  
}


//TODO 分类页面右侧商品列表
class CategoryRightList extends StatefulWidget {
  @override
  _CategoryRightListState createState() => _CategoryRightListState();
}

class _CategoryRightListState extends State<CategoryRightList> {

  GlobalKey<RefreshFooterState> _globaKey = new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
  }

  void _getCategoryRightList3()async{
    Provide.value<ChildCategoryProvide>(context).addPage();
    var dataParams = {
      'categoryId' : Provide.value<ChildCategoryProvide>(context).catrgoryId,
      'categorySubId' : Provide.value<ChildCategoryProvide>(context).subId,
      'page' : Provide.value<ChildCategoryProvide>(context).page,
    };
    await getData('getMallGoods',params: dataParams).then((val){
      var dataList = json.decode(val.toString());
      CategoryListModel categoryListModel = CategoryListModel.fromJson(dataList);
      if(categoryListModel.data == null){
        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
        );
        Provide.value<ChildCategoryProvide>(context).changeNomoreText('没有更多内容了...');
      }else{
        Provide.value<ChildCategoryRightListProvide>(context).getChildCategoryRightList2(categoryListModel.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var scrollController = new ScrollController();

    return Provide<ChildCategoryRightListProvide>(
        builder: (context,child,data){
          try{
            if(Provide.value<ChildCategoryProvide>(context).page == 1){
              //如果切换大类或小类，则把列表浏览位置重新放到最上面
              scrollController.jumpTo(0.0);
            }
          }catch(e){
            print('进入页面第一次报错');
          }
          if(data.childList.length > 0){
            return Expanded(
                child: Container(
                  width: ScreenUtil().setWidth(600),
                  child: EasyRefresh(
                    //自定义加载footer样式
                    refreshFooter: ClassicsFooter(
                      key: _globaKey,
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      moreInfoColor: Colors.pink,
                      showMore: true,
                      noMoreText: Provide.value<ChildCategoryProvide>(context).noMoreText,
                      moreInfo: '加载中',
                      loadReadyText: '上拉加载',
                    ),
                    child:  ListView.builder(
                      controller: scrollController,
                      itemCount: data.childList.length,
                      itemBuilder:(context,index){
                        return _ListItem(data.childList,index);
                      }
                    ),
                    loadMore: ()async{
                      print('开始加载更多。。。');
                      _getCategoryRightList3();
                    },
                  )
                )
            );
          }else{
            return Text('暂无数据...');
          }
        }
    );
  }

  //图片组件
  Widget _image(List newList, index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  //名称组件
  Widget _title(List newList, index){
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(400),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.black),
      ),
    );
  }

  //价钱组件
  Widget _price(List newList, index){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(400),
      child: Row(
        children: <Widget>[
          Text('价格： ¥${newList[index].presentPrice}  ',style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(30))),
          Text('¥${newList[index].oriPrice}',style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),)
        ],
      ),
    );
  }

  //组合 图片+名称+价钱 三个组件
  Widget _ListItem(List newList, index){
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
            _image(newList,index),
            Column(
              children: <Widget>[
                _title(newList,index),
                _price(newList,index),
              ],
            )
          ],
        ),
      ),
    );
  }

}







