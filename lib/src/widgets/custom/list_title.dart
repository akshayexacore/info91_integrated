import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({
    Key? key,
    this.more,
    this.title = '',
    this.moreText = 'See all',
  }) : super(key: key);

  final Function()? more;
  final String title;
  final String moreText;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Text(
        title,
        style: const TextStyle(
            fontSize: AppFontSizes.large, fontWeight: FontWeight.w500),
      )),
      if (more != null) ...[
        const SizedBox(
          width: AppSpacings.xxSmall,
        ),
        TextButton(
          style: AppButtonStyles.textButton,
          onPressed: more,
          child: Text(
            moreText,
            style: const TextStyle(
              fontSize: AppFontSizes.small,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    ]);
  }
}
