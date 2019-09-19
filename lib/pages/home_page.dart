import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_request_manger.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  //保持页面状态（1） 必须是 StatefulWidget，然后 加入混入 with AutomaticKeepAliveClientMixin
  //          （2）  重写  wantKeepAlive 返回true
  //          （3）  在使用该页面的文件 改造成返回 list  这里去indexPage 改造
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('重新加载页面');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'),),
      body:FutureBuilder(
        future: getHomePageData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            print('数据请求进来了----------------------');
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast();    // 获取顶部轮播组件数据
            List<Map> navigatorList = (data['data']['category'] as List).cast();   // 获取顶部导航组件数据
            String adbPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];// 获取广告位数据
            String leaderImage = data['data']['shopInfo']['leaderImage'];          // 获取店长图片数据
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];          // 获取店长电话数据
            List<Map> recommendList = (data['data']['recommend'] as List).cast();  // 获取商品推荐数据

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Banner(swiperDataList:swiperDataList ),    //页面顶部轮播组件
                  Navigator(navigatorList: navigatorList),   //页面顶部导航组件
                  Adv(adv: adbPicture),                      //广告位组件
                  LeaderPhone(leaderImage:leaderImage,leaderPhone:leaderPhone),//店长电话组件
                  Recommend(recommendList:recommendList),    //商品推荐组件
                ],
              ),
            );
          }else{
            print('暂时还没有进来----------------------');
            return Center(
              child: Text('加载中 . . .'),
            );
          }
        },
      ),
    );
  }

}

//首页轮播图数据
class Banner extends StatelessWidget {

  final List swiperDataList;
  Banner({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {

    print('设备像素密度： ${ScreenUtil.pixelRatio}');
    print('设备宽： ${ScreenUtil.screenWidth}');
    print('设备高： ${ScreenUtil.screenHeight}');

//    var width = MediaQuery.of(context).size.width;
//    var height = width/4*2;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }

}


//首页导航区数据
class Navigator extends StatelessWidget {

  final List navigatorList;

  Navigator({Key key, item, this.navigatorList}):super(key:key);

  Widget _navigatorListUi(BuildContext context,item){
    return InkWell(
      onTap: (){
        print('点击进入');
//        _goCategoryDetail(context,index,item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      )
    );
  }

//  void _goCategoryDetail(context,int index,String categroyId) async{
//    await request('getCategory').then((val){
//      var data = json.decode(val.toString());
//    });
//  }

  @override
  Widget build(BuildContext context) {

    if(navigatorList.length>10){
      navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top:5.0),
      height: ScreenUtil().setHeight(330),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _navigatorListUi(context,item);
        }).toList(),//一定要记得最后 toList() 要不然报错：type 'MappedListIterable<Map<dynamic,dynamic>,Widget>'is not a subtype of type 'List<Widget>'
      ),
    );
  }
}


//首页广告位数据
class Adv extends StatelessWidget {
  final String adv;
  Adv({Key key,this.adv}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adv),
    );
  }
}


//首页店长电话数据
class LeaderPhone extends StatelessWidget {

  final String leaderImage;
  final String leaderPhone;
  LeaderPhone({Key key,this.leaderImage, this.leaderPhone}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Image.network(leaderImage),
        onTap: _CallPhone,
      ),
    );
  }

  //打电话
  void _CallPhone()async{
    String phone = 'tel:'+leaderPhone;
    if(await canLaunch(phone)){
      await launch(phone);
    }else{
      throw '对不起，因为某些原因电话打不通...';
    }
  }

}


//首页商品推荐数据
class Recommend extends StatelessWidget {

  final List recommendList;
  Recommend({Key key,this.recommendList}):super(key:key);

  //商品推荐标题
  Widget _recommendTitle(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品推荐内容
  Widget _recommendList(){
    return Container(
      height: ScreenUtil().setHeight(325),
      child: ListView.builder(
        itemCount: recommendList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return _recommendContent(index);
        }
      ),
    );
  }

  //商品推荐内容item
  Widget _recommendContent(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(320),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 0.5,
              color: Colors.black12
            ),
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black12
            )
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey,fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: ScreenUtil().setHeight(400),
      child: Column(
        children: <Widget>[
          _recommendTitle(),//商品推荐标题
          _recommendList(),//商品推荐内容
        ],
      ),
    );
  }
}






















































//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//  String showText = '请求成功后，一会我就要变身了...';
//
//  @override
//  void initState() {
//    getHomePageData().then((val){
//      setState(() {
//        showText = val.toString();
//        print("马龙--------------------"+showText);
//      });
//    });
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('首页'),),
//      body: SingleChildScrollView(
//        child: Text(showText),
//      ),
//    );
//  }
//
//}










//import 'package:dio/dio.dart';
//import '../config/http_header.dart';
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//  var showText = '还没开始请求';
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Container(
//      child: Scaffold(
//        appBar: AppBar(title: Text('伪造请求头'),),
//        body: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              RaisedButton(
//                onPressed: _requestJiKe,
//                child: Text('开始请求'),
//              ),
//              Text(showText)
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  void _requestJiKe(){
//    print('准备请求');
//    getHttp().then((val){
//      setState(() {
//        showText = val['data'].toString();
//      });
//    });
//  }
//
//  Future getHttp() async{
//    try{
//      Response response;
//      Dio dio = new Dio();
//      dio.options.headers = http_header;
//      response = await dio.post('https://time.geekbang.org/serv/v1/column/topList');
//      print(response.data);
//      return response.data;
//    }catch(e){
//      print(e);
//    }
//  }
//
//}




















//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//  TextEditingController _controller = TextEditingController();
//  String showText = '小伙子，现在你要开始起飞了 ~ ~';
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Scaffold(
//        appBar: AppBar(title: Text('动态请求后台替换页面')),
//        body: SingleChildScrollView(
//          child: Container(
//            child: Column(
//              children: <Widget>[
//                TextField(
//                  controller: _controller,
//                  decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(10.0),
//                      labelText: '想要啥样的小姐类型？',
//                      helperText: '来吧，别害羞，填上你喜欢的类型'
//                  ),
//                  autofocus: false,
//                ),
//                RaisedButton(
//                  onPressed: _clickAction,
//                  child: Text('选择完毕，go!!!'),
//                ),
//                Text(
//                  showText,
//                  overflow: TextOverflow.ellipsis,
//                  maxLines: 1,
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  //点击请求时判断逻辑
//  void _clickAction(){
//    print('开始选择你要的小姐');
//    if(_controller.text.toString()==''){
//      showDialog(
//        context: context,
//        builder: (context)=>AlertDialog(title: Text('别不选啊，小伙子'),)
//      );
//    }else{
//      getRequest(_controller.text.toString()).then((onValue){
//        setState(() {
//          showText=onValue['data']['name'].toString();
//        });
//      });
//    }
//  }
//
//  //网络请求开始
//  Future getRequest(String inPutName) async{
//    try{
//      Response response;
//      var name = {'name':inPutName};
////      response = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',queryParameters: name);
//      response = await Dio().post('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_abaojian',queryParameters: name);
//      return response.data;
//    }catch(e){
//      return print(e);
//    }
//  }
//
//}
















//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//
//    getRequest();
//
//    return Scaffold(
//      body: Center(
//        child: Text(
//          '首页'
//        ),
//      ),
//    );
//  }
//
//  void getRequest()async {
//    Response response;
//    try{
//      response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸女");
//      return print(response);
//    }catch(e){
//      print(e);
//    }
//  }
//}
