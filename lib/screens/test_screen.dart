import 'package:flutter/material.dart';
import 'package:flutter_todo/responsive.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [

          if (Responsive.isMobile(context))
            Expanded(
              child: Container(
                child: Text(
                  'سایز موبایل',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.red,
                alignment: Alignment.center,
              ),
            ),



          if (Responsive.isTablet(context))
            Expanded(
              child: Container(
                child: Text(
                  'سایز تبلت',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.yellow,
                alignment: Alignment.center,
              ),
            ),



          if (Responsive.isDesktop(context))
            Expanded(
              child: Container(
                child: Text(
                  'سایز دسکتاپ',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.green,
                alignment: Alignment.center,
              ),
            ),
        ],
      ),
    );
  }
}
