import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_request_manger.dart';

//TODO 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String showText = '请求成功后，一会我就要变身了...';

  @override
  void initState() {
    getHomePageData().then((val){
      setState(() {
        showText = val.toString();
        print("马龙--------------------"+showText);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'),),
      body: SingleChildScrollView(
        child: Text(showText),
      ),
    );
  }

}










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
