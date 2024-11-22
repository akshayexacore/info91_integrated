import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final Color color;

  const CustomLoading({
    Key? key,
    this.size = 50.0,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          backgroundColor: color.withOpacity(0.3),
        ),
      ),
    );
  }
}