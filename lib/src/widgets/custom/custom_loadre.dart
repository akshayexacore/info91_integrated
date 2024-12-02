import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final dynamic progress;
  final String? message;

  const CustomLoader({this.progress, Key? key,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
    alignment: Alignment.center,
      child: Container(
        height: 100,
        width: 150,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
              message??"Loading...." ,
                style:const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
