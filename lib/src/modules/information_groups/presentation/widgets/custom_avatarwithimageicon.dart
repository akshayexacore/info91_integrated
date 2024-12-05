import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';

class ReusableAvatarWithIcon extends StatelessWidget {
  final ImageProvider profileImage;
  final double radius;
  final bool showIcon;
  final Widget? iconWidget;

  final Alignment iconAlignment;

  const ReusableAvatarWithIcon({
    required this.profileImage,
    this.radius = 35.0,
    this.showIcon = false,
    this.iconWidget,
    this.iconAlignment = Alignment.bottomRight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: radius - 4.0, // Adjust to create a border effect
            backgroundImage: profileImage,
          ),
        ),
        if (showIcon && iconWidget != null) iconWidget!,
      ],
    );
  }
}

class CustomCircleIconWidget extends StatefulWidget {
  final VoidCallback onCange;
  final Color backgroundClr;
  final Widget? centerWidget;
  final IconData iconData;
  final double radius;
  final Color iconColor;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressEnd;
  final Function? onLongPressMoveUpdate;
  final double iconSize;
  const CustomCircleIconWidget(
      {super.key,this.onLongPressMoveUpdate,
      this.iconColor = AppColors.white,
      required this.onCange,
      this.radius = 12.5,
      this.iconSize = 15,
      this.backgroundClr = AppColors.secondary,
      this.centerWidget,
      this.iconData = Icons.check,
      this.onLongPress,
      this.onLongPressEnd});

  @override
  State<CustomCircleIconWidget> createState() => _CustomCircleIconWidgetState();
}

class _CustomCircleIconWidgetState extends State<CustomCircleIconWidget> {
  Offset _position = Offset.zero;
   Offset _startPosition = Offset.zero;
 double _radius =20.0; 
 double _positionX = 0.0; 
 double deltaX=0.0;
  void _onLongPressStart(LongPressStartDetails details) {
     _radius = 30.0;
    setState(() {
      _startPosition = details.localPosition;
      _positionX = details.localPosition.dx;
    });
   
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    setState(() {
      _position = details.localPosition;
        _positionX = details.localPosition.dx; 
         deltaX = _position.dx - _startPosition.dx;
        if(widget.onLongPressMoveUpdate!=null){
         widget. onLongPressMoveUpdate!(deltaX);
         if(deltaX<-65){   deltaX=0.0;}
      
        }
       print("sssssssssssssssd$deltaX");  // Update the position as the user slides
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onCange,
        onLongPress: widget.onLongPress,
        onLongPressEnd: (va) {
          _radius=20;
           _positionX = 0.0;
           deltaX=0.0;
          setState(() {
            
          });
          widget.onLongPressEnd!();
        },
        onLongPressStart: _onLongPressStart,
        onLongPressMoveUpdate: _onLongPressMoveUpdate,
        
        child: AnimatedContainer(
        margin: EdgeInsets.only(right: deltaX.abs()),
        duration: Duration(milliseconds: 150), // Duration of the radius increase
        curve: Curves.easeOut, // Smooth curve for the bounce effect
        width: _radius * 2, // Width is twice the radius
        height: _radius * 2, 
        
        // Height is twice the radius
        decoration: BoxDecoration(
          color: widget.backgroundClr,
          shape: BoxShape.circle,
        ),
          child: widget.centerWidget != null
              ? widget.centerWidget
              : Center(
                  child: Icon(
                  widget.iconData,
                  color: widget.iconColor,
                  size: widget.iconSize.sp,
                )),
        ));
  }
}
