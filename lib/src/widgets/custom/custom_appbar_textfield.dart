import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

  class CustomAppBatTexField extends StatefulWidget {
  final TextEditingController cntroler;
  const CustomAppBatTexField({
    super.key,
    required this.onChangeFunction, required this.cntroler,
  });

  final Function? onChangeFunction;

  @override
  State<CustomAppBatTexField> createState() => _CustomAppBatTexFieldState();
}

 class _CustomAppBatTexFieldState extends State<CustomAppBatTexField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.1),
            borderRadius: BorderRadius.circular(AppRadii.xSmall),),
        child: TextFormField(
          controller: widget.cntroler,
        
          style: TextStyle(color: Colors.white),
          onChanged: (String va) {
            if (widget.onChangeFunction != null) {
              widget.onChangeFunction!(va);
            }setState(() {
              
            });
          },
          decoration: InputDecoration(
            
              border: InputBorder.none,

              labelStyle:const TextStyle(color: Colors.white),
              prefixIcon:Container(
                        height: 16,
                        width: 16 + 9,
                        padding: const EdgeInsets.only(right: 9),
                        margin: const EdgeInsets.only(
                          top: 7,
                          bottom: 7,
                          right: 9,
                          left: 14,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color:
                                        AppColors.white.withOpacity(0.5)))),
                        child: AppSvgAsset(
                          "assets/images/ic_search.svg",
                          fit: BoxFit.contain,
                          color: AppColors.white.withOpacity(0.5),
                        ),
                      ),
             suffixIcon:widget.cntroler.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.white,size: 20.sp,),
                  onPressed: () {
                    widget.cntroler.clear();
                    if (widget.onChangeFunction != null) {
                     widget.onChangeFunction!('');
                    }
                    setState(() {
                      
                    });
                  },
                )
              : null,
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white.withOpacity(.5),fontSize: 13.sp)),
        ));
  }
}
