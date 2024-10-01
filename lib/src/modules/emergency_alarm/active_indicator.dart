import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';

class ActiveIndicator extends StatefulWidget {
  const ActiveIndicator({Key? key}) : super(key: key);

  @override
  State<ActiveIndicator> createState() => _ActiveIndicatorState();
}

class _ActiveIndicatorState extends State<ActiveIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController markerController;

  @override
  void initState() {
    super.initState();
    markerController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1,
    )..repeat();
  }

  @override
  void deactivate() {
    super.deactivate();
    markerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ActiveIndicatorAnimated(markerController);
  }
}

class _ActiveIndicatorAnimated extends AnimatedWidget {
  const _ActiveIndicatorAnimated(
    Listenable controller, {
    Key? key,
  }) : super(key: key, listenable: controller);

  Animation<double> get _size => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 170 * _size.value,
            width: 170 * _size.value,
            decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(170)),
          ),
          Container(
            height: 145 * _size.value,
            width: 145 * _size.value,
            decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.35),
                borderRadius: BorderRadius.circular(170)),
          ),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: AppColors.red, borderRadius: BorderRadius.circular(170)),
          ),
        ],
      ),
    );
  }
}
