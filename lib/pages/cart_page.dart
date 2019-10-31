import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//todo 购物车页面
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> list = [];

  @override
  Widget build(BuildContext context) {

    _show();

    return Scaffold(
      appBar: AppBar(title: Text('分类')),
      body: Container(
        child: ListView(
          children: <Widget>[

            Container(
                height: 400,
                color: Colors.teal,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(list[index]),
                    );
                  },
                )
            ),

            RaisedButton(
              color: Colors.red,
              onPressed: (){
                _add();
              },
              child: Text('增加'),
            ),

            RaisedButton(
              color: Colors.green,
              onPressed: (){
                _clear();
              },
              child: Text('清空'),
            ),

          ],
        ),
      ),
    );
  }

  //添加
  void _add()async{
    SharedPreferences sp1 = await SharedPreferences.getInstance();
    String ml = '大家好，我是最靓的仔';
    list.add(ml);
    sp1.setStringList("mlong", list);
    _show();
  }

  //展示
  void _show()async{
    SharedPreferences sp2 = await SharedPreferences.getInstance();
    if(sp2.getStringList('mlong') != null){
      setState((){
        list = sp2.getStringList('mlong');
      });
    }
  }

  //清空
  void _clear()async{
    SharedPreferences sp3 = await SharedPreferences.getInstance();
    //sp3.clear();
    sp3.remove('mlong');
    setState((){
      list = [];
    });
  }
}




