import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/chat.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppMessageStatus extends StatelessWidget {
  const AppMessageStatus({
    super.key,
    this.messageStatus = MessageStatus.none,
    this.time = '',
  });

  final MessageStatus messageStatus;

  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        if (messageStatus != MessageStatus.none)
          SizedBox(
            height: 16,
            width: 16,
            child: AppSvgAsset(
              messageStatus == MessageStatus.delivered ||
                      messageStatus == MessageStatus.seen
                  ? 'assets/images/ic_tick_double.svg'
                  : 'assets/images/ic_tick.svg',
              color: messageStatus == MessageStatus.seen
                  ? AppColors.blue
                  : AppColors.text,
            ),
          ),
        if (time.isNotEmpty) ...[
          if (messageStatus != MessageStatus.none)
            const SizedBox(
              width: 8,
            ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ]
      ],
    );
  }
}
