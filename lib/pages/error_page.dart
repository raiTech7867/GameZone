import 'package:flutter/material.dart';
class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:const Center(child:Text("Page doesn't Exist")
        ),
      ),
    );
  }
}
