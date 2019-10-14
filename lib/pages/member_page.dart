import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Provide<Counter>(
          builder: (context,child,counter){
            return Text('${counter.value}');
          }
      ),
    );
  }
}


class Num extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Provide<Counter>(
          builder: (context,child,counter){
            return Text('${counter.value}');
          }
      ),
    );
  }
}