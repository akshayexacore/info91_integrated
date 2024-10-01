import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppPopupMenuButton extends StatelessWidget {
  const AppPopupMenuButton({
    super.key,
    this.children = const [],
  });

  final List<AppPopupMenuItem> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerTheme: const DividerThemeData(
          color: AppColors.offWhite,
        ),
      ),
      child: AppInkWell(
        onTap: children.isNotEmpty
            ? () {
                _showMenu(context);
              }
            : null,
        borderRadius: 24,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 30,
            child: Center(
              child: SizedBox(
                height: 22,
                child: AppSvgAsset(
                  'assets/images/ic_dots.svg',
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<int>> _buildMenuItems() {
    List<PopupMenuEntry<int>> menuItems = [];
    List.generate(children.length, (index) {
      if (index == children.length - 1) {
        menuItems.add(PopupMenuItem<int>(
          height: 35,
          value: index,
          child: children[index],
        ));
      } else {
        menuItems.addAll(<PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            height: 35,
            value: index,
            child: children[index],
          ),
          const PopupMenuDivider(),
        ]);
      }
    });
    return menuItems;
  }

  void _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      const Offset(10, -24) & overlay.size,
    );
    showMenu<int>(
      context: context,
      color: AppColors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      position: RelativeRect.fromLTRB(
          position.left, position.top, position.right, position.bottom),
      items: _buildMenuItems(),
    ).then((value) {
      if (value != null) {
        children[value].onPressed?.call();
      }
    });
  }
}

class AppPopupMenuItem extends StatelessWidget {
  const AppPopupMenuItem({
    super.key,
    required this.title,
    this.icon = '',
    this.onPressed,
  });

  final String title;

  final String icon;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (icon.isNotEmpty) ...[
          AppSvgAsset(
            'assets/images/$icon',
          ),
          const SizedBox(
            width: AppSpacings.xSmall,
          ),
        ],
        Text(
          title,
          style: const TextStyle(
            fontSize: AppFontSizes.small15,
          ),
        ),
      ],
    );
  }
}
