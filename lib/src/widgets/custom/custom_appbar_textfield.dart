import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            borderRadius: BorderRadius.circular(12)),
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
                 contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.white.withOpacity(.5),
                size: 28,
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
              hintStyle: TextStyle(color: Colors.white.withOpacity(.5))),
        ));
  }
}
