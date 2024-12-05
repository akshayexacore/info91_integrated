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
        },onOpened: (){
          print("opening the area");
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
class AdminTableDotIcon extends StatefulWidget {
  final Function onTap;
  final Function? mouseHoverFunc;
  final Color? clr;
  final Color? iconClr;
  final IconData? icons;
  final double? iconSize;
  final double?  height;
  final List<customPopupmenuButton>valueList;
  AdminTableDotIcon({required this.onTap, required this.valueList, this.mouseHoverFunc, this.clr, this.icons, this.iconSize, this.iconClr, this.height});





  @override
  State<AdminTableDotIcon> createState() => _AdminTableDotIconState();
}

class _AdminTableDotIconState extends State<AdminTableDotIcon> {
  bool isHover=false;


  @override
  Widget build(BuildContext context) {
    return     PopupMenuButton(
      color:   Colors.white,
      padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        offset: Offset(0, 5.h),
      position: PopupMenuPosition.over,
      onCanceled : (){

      },
      onSelected: (val){
        print("aaaaaaaaaaaaaa");
        widget.onTap(val);
      },

      itemBuilder: (context) {
        final List<PopupMenuEntry<String>> popupItems = widget.valueList!.map((customPopupmenuButton item) {
          return PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            value: item.value,
             height: 25,
            child:Container(child: Center(  child: Text(item.label,style: TextStyle(color: Colors.black,fontSize: 12),)),),
          );

        }).toList();

        return
          popupItems;

      },

      icon: Center(child: Icon(widget.icons??Icons.more_horiz,size:widget.iconSize??25,color: isHover?Colors.grey:widget.iconClr??Colors.grey.withOpacity(.6)),),
    );
  }
}class customPopupmenuButton{
  final String value;
  final String label;
  customPopupmenuButton({required this.value,required this.label});
}