import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    Key? key,
    this.currentIndex = 0,
    required this.onTap,
    this.unselectedItemColor,
    this.selectedItemColor,
    required this.items,
  })  : assert(items.length >= 2),
        assert(items.length <= 5),
        assert(currentIndex < items.length),
        super(key: key);

  final List<AppBottomNavigationBarItem> items;
  final int currentIndex;

  final Function(int index) onTap;

  final Color? unselectedItemColor;

  final Color? selectedItemColor;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;

  void _resetState() {
    for (final AnimationController controller in _controllers) {
      controller.dispose();
    }

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant AppBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }
    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final AnimationController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);
    final Color themeColor;
    switch (themeData.brightness) {
      case Brightness.light:
        themeColor = themeData.colorScheme.primary;
        break;
      case Brightness.dark:
        themeColor = themeData.colorScheme.secondary;
        break;
    }
    final Color selectedColor =
        widget.selectedItemColor ?? bottomTheme.selectedItemColor ?? themeColor;
    final Color unselectedColor = widget.unselectedItemColor ??
        bottomTheme.unselectedItemColor ??
        themeData.unselectedWidgetColor;
    final colorTween = ColorTween(
      begin: unselectedColor,
      end: selectedColor,
    );
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPaddings.xxxSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < widget.items.length; i++)
              _AppBottomNavigationTile(
                onTap: () {
                  widget.onTap.call(i);
                },
                item: widget.items[i],
                selected: widget.currentIndex == i,
                colorTween: colorTween,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
                animation: _animations[i],
                firstItem: i == 0,
                lastItem: i == widget.items.length - 1,
              )
          ],
        ),
      ),
    );
  }
}

class _AppBottomNavigationTile extends StatelessWidget {
  const _AppBottomNavigationTile({
    Key? key,
    this.onTap,
    this.selected = false,
    required this.item,
    required this.colorTween,
    required this.animation,
    required this.selectedColor,
    required this.unselectedColor,
    this.firstItem = false,
    this.lastItem = false,
  }) : super(key: key);

  final VoidCallback? onTap;

  final bool selected;

  final ColorTween colorTween;

  final Animation<double> animation;

  final Color selectedColor;

  final Color unselectedColor;

  final AppBottomNavigationBarItem item;

  final bool firstItem;

  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = colorTween.evaluate(animation);
    final IconThemeData defaultIconTheme = IconThemeData(
      color: iconColor,
      size: AppSizes.bottomNavigationIconSize,
    );
    final IconThemeData iconThemeData = IconThemeData.lerp(
      defaultIconTheme.copyWith(color: unselectedColor),
      defaultIconTheme.copyWith(color: selectedColor),
      animation.value,
    );
    Widget result = InkResponse(
      onTap: onTap,
      enableFeedback: true,
      child: Column(
        children: [
          const SizedBox(
            height: AppSpacings.medium,
          ),
          SizedBox(
            height: AppSizes.bottomNavigationIconSize,
            width: AppSizes.bottomNavigationIconSize,
            child: AppSvgAsset(
              selected ? item.activeAsset : item.asset,
              color: iconThemeData.color,
            ),
          ),
          SizedBox(
            height: AppSpacings.medium,
            child: selected
                ? Container(
                    height: 6,
                    width: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ))
                : const SizedBox(),
          )
        ],
      ),
    );
    result = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small),
      child: result,
    );
    return result;
  }
}

class AppBottomNavigationBarItem {
  const AppBottomNavigationBarItem(
      {Key? key, required this.asset, String? activeAsset})
      : activeAsset = activeAsset ?? asset;
  final String asset;

  final String activeAsset;
}
