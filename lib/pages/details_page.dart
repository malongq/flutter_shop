import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {

  final String cId;
  DetailsPage(this.cId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品详情ID为：  ${cId}'),
    );
  }

}
