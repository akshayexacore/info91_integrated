import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.hintText,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.minLines,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController? controller;

  final TextInputType? keyboardType;

  final Widget? prefix;

  final Widget? suffix;

  final ValueChanged<String>? onChanged;

  final String? hintText;

  final bool obscureText;

  final TextAlign textAlign;

  final int? maxLines;

  final int? minLines;

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (prefix != null) ...[
          prefix!,
          const SizedBox(
            width: AppSpacings.xxSmall,
          ),
        ],
        Expanded(
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: AppFontSizes.small,
              fontWeight: FontWeight.w500,
            ),
            onChanged: onChanged,
            obscuringCharacter: '●',
            textAlign: textAlign,
            obscureText: obscureText,
            maxLines: obscureText ? 1 : maxLines,
            minLines: minLines,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.text.withOpacity(0.75),
                fontSize: AppFontSizes.xxSmall,
                fontWeight: FontWeight.w500,
              ),
              prefixStyle: const TextStyle(
                color: AppColors.white,
                fontSize: AppFontSizes.xxSmall,
                fontWeight: FontWeight.w500,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            ),
          ),
        ),
        if (suffix != null) ...[
          const SizedBox(
            width: AppSpacings.xxSmall,
          ),
          suffix!,
        ],
      ],
    );
  }
}
