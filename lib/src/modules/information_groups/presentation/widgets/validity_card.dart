import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';

class ValidityCard extends StatelessWidget {
  final String amount;
  final String planName;
  final Function onChange;
  final bool isSelected;
  const ValidityCard({
    super.key,
    required this.amount,
    required this.planName,
    required this.onChange,
    this.isSelected=false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onChange();
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Grey shadow color
                spreadRadius: 1,
                blurRadius: 1, // Blur radius
                offset: Offset(0, 0.7), // Shadow position
              ),
            ],borderRadius: BorderRadius.circular(12),
            // border: Border.all(color: Colors.grey.withOpacity(.5), width: .5,radius:),
            color:isSelected?AppColors.primary.withOpacity(.1): Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  isSelected?"assets/images/selected.png":"assets/images/selected-disabled.png",
                  height: 22.h,
                  
                  color: Color.fromARGB(255, 6, 46, 78),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  planName,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            Row(
              children: [
                Text(
                  "Amount",
                  style: TextStyle(color: Color(0xff333333).withOpacity(.75)),
                ),
                const Spacer(),
                Text(
                  amount,
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
