import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info_provide.dart';
import '../pages/details_page/details_top.dart';
import '../pages/details_page/details_explan.dart';

//todo 首页商品火爆专区详情页面
class DetailsPage extends StatelessWidget {

  final String cId;
  DetailsPage(this.cId);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);}),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getData(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container(
              child: ListView(
                children: <Widget>[
                 DetailsTop(),
                 DetailsExplan(),
                ],
              ),
            );
          }else{
            return Text('加载中。。。');
          }
        },
      ),
    );
  }

  Future _getData(BuildContext context)async{
    await Provide.value<DetailsInfoProvide>(context).getDetailInfo(cId);
    return '首页商品火爆专区数据请求完毕。。。。。。。。。。。。。';
  }

}
