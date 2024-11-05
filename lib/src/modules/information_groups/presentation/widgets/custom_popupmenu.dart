import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';

class CustomPopupmenu extends StatelessWidget {
  final Function onSelected;
  final List<popupMenuModel> itemList;
  const CustomPopupmenu(
      {super.key, required this.onSelected, required this.itemList});

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
        icon: const Icon(
          Icons.more_vert,
          color: AppColors.white,
        ));
  }
}

// ignore: camel_case_types
class popupMenuModel {
  int value;
  String name;
  popupMenuModel({required this.name, required this.value});
}
