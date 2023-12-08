
import 'package:flutter/cupertino.dart';
import 'package:invtest2/UI/widgets/styletext.dart';


class Text1 extends StatelessWidget {
  final String text;

  Text1({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Text(
          text,
          style:AppTextStyles.fonttext,
        ));
  }
}
class Text2 extends Text1 {
  Text2({required super.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            text,
            style: AppTextStyles.bText1,
          ),
          Image.asset(
            "images/img.png",
            width: 10,
            height: 10,
          )
        ],
      ),
    );
  }
}