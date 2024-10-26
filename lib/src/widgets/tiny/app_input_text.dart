import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:info91/src/configs/app_styles.dart';

class AppInputText extends StatelessWidget {
  const AppInputText({
    Key? key,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.prefixText,
    this.cursorColor,
    this.maxLength,this.isError=false,

    this.textAlign = TextAlign.start,
    this.border = true,
    this.shadow = false,
    this.onlyNumbers = false, 
    this.obscureText = false,
    this.isUnderlinedBorder = false,
    this.prefixIcon,
    this.minLines,this.onChanged,
    this.borderColor = AppColors.border,
    this.suffixText,
    this.suffixIcon,
    this.radius = AppRadii.medium,
    this.hintTextStyle = AppTextStyles.inputHintText,
    this.textStyle = AppTextStyles.inputText,this.errormessage="",
    this.isDense  = false,
  }) : super(key: key);
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Color? cursorColor;
  final String? prefixText;
  final Widget? prefixIcon;
  final int? maxLength;
  final String? suffixText;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final bool border;
  final Color borderColor;
  final bool shadow;
  final bool isUnderlinedBorder;
  final bool obscureText;
  final int? minLines;
  final double radius;
    final bool onlyNumbers; // 
  final TextStyle hintTextStyle;
  final TextStyle textStyle;
   final Function? onChanged;
  final String errormessage;
  final bool isError;

  final bool isDense;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = isUnderlinedBorder
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(AppRadii.xSmall))
        : OutlineInputBorder(
            borderSide: border
                ? BorderSide(color: borderColor, width: 1)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadii.xSmall));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: shadow ? [AppShadows.shadow] : null),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style:textStyle,
            maxLength:maxLength?? null,
            keyboardType: keyboardType,
            cursorColor: cursorColor,
            textAlign: textAlign,onChanged: (value){if(onChanged!=null){onChanged!(value);}},
            maxLines: (minLines != null && minLines! > 1) ? minLines : 1,
            minLines: minLines,
            inputFormatters: onlyNumbers ? [FilteringTextInputFormatter.digitsOnly] : [],
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixText != null || prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppPaddings.inputTextVertical,
                        horizontal: AppPaddings.inputTextHorizontal,
                      ),
                      child: prefixText != null
                          ? Text(
                              prefixText!,
                              style: AppTextStyles.inputText,
                            )
                          : prefixIcon,
                    )
                  : null,
              suffixIcon: suffixText != null || suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppPaddings.inputTextVertical,
                        horizontal: AppPaddings.inputTextHorizontal,
                      ),
                      child: suffixText != null
                          ? Text(
                              suffixText!,
                              style: AppTextStyles.inputText,
                            )
                          : suffixIcon,
                    )
                  : null,
              filled: isUnderlinedBorder ? false : true,
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder.copyWith(
                  borderSide: isUnderlinedBorder
                      ? BorderSide(width: 1.5, color: borderColor)
                      : const BorderSide(color: AppColors.primary)),
              errorBorder: outlineInputBorder,
              focusedErrorBorder: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              fillColor: AppColors.white.withOpacity(0.1),
              focusColor: AppColors.white,
              hintStyle: hintTextStyle,
              prefixStyle: AppTextStyles.inputText,
              hintMaxLines: 1,
              isDense: isUnderlinedBorder || isDense ? true : null,
              contentPadding: EdgeInsets.symmetric(
                horizontal:
                    isUnderlinedBorder ? 0 : AppPaddings.inputTextHorizontal,
                vertical: isUnderlinedBorder ? 8 : AppPaddings.inputTextVertical,
              ),
            ),
          ),
        ),
        if (errormessage != null && !errormessage.isEmpty)
            Text(
              errormessage!,
              style: TextStyle(color:isError? Colors.red:AppColors.primary, fontSize: 12), // Error message style
            ),
      ],
    );
  }
}
