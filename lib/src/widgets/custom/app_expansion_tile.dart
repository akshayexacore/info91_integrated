import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';

class AppExpansionTile extends StatefulWidget {
  final List<Widget> children;

  final bool maintainState;

  final String title;

  const AppExpansionTile(
      {Key? key,
      required this.title,
      this.children = const [],
      this.maintainState = false})
      : super(key: key);

  @override
  State<AppExpansionTile> createState() => _AppExpansionTileState();
}

class _AppExpansionTileState extends State<AppExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.125);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  final Duration _kExpand = const Duration(milliseconds: 200);

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
  }

  Widget _buildIcon() {
    return RotationTransition(
      turns: _iconTurns,
      child: const Icon(
        Icons.add_sharp,
        color: AppColors.hint,
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return AppInkWell(
      onTap: _handleTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: AppPaddings.xSmall,
          ),
          Row(children: [
            Expanded(
              child: _buildTitle(),
            ),
            _buildIcon()
          ]),
          ClipRect(
            child: Align(
              alignment: Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
          const SizedBox(
            height: AppPaddings.xSmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.children,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }

  Widget _buildTitle() {
    return AnimatedContainer(
      duration: _kExpand,
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: AppFontSizes.large,
          fontWeight: _isExpanded ? FontWeight.w600 : null,
        ),
      ),
    );
  }
}
