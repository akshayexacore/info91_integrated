import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';

class CustomPopupmenu extends StatelessWidget {
  final Function onSelected;
  final Color iconColr;
  final IconData icon;
  final List<popupMenuModel> itemList;
  final Widget? iconWidget;
   CustomPopupmenu(
      {super.key, required this.onSelected, required this.itemList,this.iconColr=AppColors.white,this.icon= Icons.more_vert,this.iconWidget});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        offset: Offset(0, 40.h),
        onSelected: (value) {
          onSelected(value);
        },
        itemBuilder: (context) {
          return itemList
              .map(
                (element) => PopupMenuItem(
                  height: 35,
                  value: element.value,
                  child: Text(
                    element.name,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              )
              .toList();
        },
        icon: iconWidget?? Icon(
          icon,
          color: iconColr,
        ));
  }
}

// ignore: camel_case_types
class popupMenuModel {
  int value;
  String name;
  popupMenuModel({required this.name, required this.value});
}
