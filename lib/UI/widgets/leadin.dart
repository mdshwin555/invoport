import 'package:flutter/material.dart';

import '../../constance/mycolor.dart';

class Leading extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.zero,
          child: Icon(

            Icons.chevron_left,
            size: 40,
            color: MyColor.blue,
          ),
        )
    );
  }
}
