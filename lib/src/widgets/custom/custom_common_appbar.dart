import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/custom_appbar_textfield.dart';
import 'package:info91/src/widgets/custom/custom_circle_image.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarName;
  final bool isTextield;
  final bool isPic;
  final Function? imageOntap;
  final String? imageUrl;

  final TextEditingController? textEditingController;

  final Function? onChangeFunction;
  final List<Widget>? actionWidget;
  final VoidCallback? onBackButtonPress;
  const CustomAppBar({
    required this.appBarName,
    this.onChangeFunction,
    this.actionWidget,
    this.isPic = false,
    this.isTextield = false,
    super.key,
    this.imageUrl,
    this.imageOntap,
    this.textEditingController,
    this.onBackButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      if (Navigator.of(context).canPop()) {
        if (onBackButtonPress != null) {
          onBackButtonPress!();
        } else {
          Navigator.of(context).pop();
        }
        return false; // Prevent default behavior
      } else {
        return true; // Allow default behavior if no routes to pop
      }
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, ),
        color: AppColors.primaryAccent,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon:  Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,size: 20.sp,
                      
                    ),
                    onPressed: () {
                      if (onBackButtonPress != null) {
                        onBackButtonPress!();
                      } else {
                        onWillPop();
                      }
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  if (isPic) ...[
                    circle_image(
                        avatarUrl: imageUrl ?? "",
                        onTap: () {
                          if(imageOntap!=null){ imageOntap!();}
                         
                        }),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                  Text(appBarName,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          fontSize: 15.sp)),
                  const Spacer(),
                  if (actionWidget != null && actionWidget?.isNotEmpty == true)
                    ...List.generate(
                        actionWidget!.length, (index) => actionWidget![index]),

                  // actionWidget != null
                  //     ? actionWidget.runtimeType == String
                  //         ? TextButton(
                  //             onPressed: () {
                  //               if (actionFunctions != null) {
                  //                 actionFunctions!();
                  //               }
                  //             },
                  //             child: Text(
                  //               actionWidget,
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold),
                  //             ))
                  //         : IconButton(
                  //             onPressed: () {},
                  //             icon: actionWidget,
                  //             color: Colors.white,
                  //           )
                  //     : SizedBox()
                ],
              ),
              if (isTextield)
                CustomAppBatTexField(
                  onChangeFunction: onChangeFunction,
                  cntroler: textEditingController ?? TextEditingController(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
