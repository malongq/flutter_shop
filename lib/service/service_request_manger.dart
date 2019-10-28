import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';

//获取首页内容
Future getData(url,{params}) async{

  try{
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");

    if(params == null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data: params);
    }

    if(response.statusCode == 200){
//      print('请求数据成功: 马龙=========>'+response.data);
      return response.data;
    }else{
      throw Exception('请求服务端出错！！！');
    }
  }catch(e){
    return print('ERROR: 马龙=========>${e}');
  }

}


///抽取请求类
///发现首页内容接口和首页火爆专区内容接口请求基本相同
///所以开始进行抽取
///上面是抽取后的类


//获取首页内容
Future getHomePageData() async{

  try{
    print('开始请求数据...');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    var param = {'lon':'115.02932','lat':'35.76189'};
    response = await dio.post(servicePath['homePageUrl'],data: param);
    if(response.statusCode == 200){
      print('请求数据成功: 马龙=========>'+response.data);
      return response.data;
    }else{
      throw Exception('请求服务端出错！！！');
    }
  }catch(e){
    return print('ERROR: 马龙=========>${e}');
  }

}

//获取首页火爆专区内容
Future getHomeHotData() async{

  try{
    print('开始请求数据...');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;
    response = await dio.post(servicePath['homeHotLocationUrl'],data: page);
    if(response.statusCode == 200){
      print('请求数据成功: 马龙=========>'+response.data);
      return response.data;
    }else{
      throw Exception('请求服务端出错！！！');
    }
  }catch(e){
    return print('ERROR: 马龙=========>${e}');
  }

}
