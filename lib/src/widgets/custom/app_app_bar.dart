import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppAppBar extends StatelessWidget {
  const AppAppBar({
    Key? key,
    this.title = '',
    this.titleWidget,
    this.toolbarHeight = AppSizes.appBarHeight,
    this.padding = AppPaddings.appBarDefault,
    this.leading,
    this.action,
    this.bottom,
    this.autoImplyLeading = true,
    this.showSearch = true,
    this.isDialogue = false,
    this.leadingLeftPadding = true,
    this.onClose,
    this.leadingPadding = 20,
    this.disableActionPadding = false,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final double toolbarHeight;
  final double padding;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final Widget? action;
  final bool autoImplyLeading;
  final bool isDialogue;
  final bool showSearch;
  final bool leadingLeftPadding;
  final double leadingPadding;
  final VoidCallback? onClose;
  final bool disableActionPadding;

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    return Container(
      color: AppColors.primary,
      child: Padding(
        padding: EdgeInsets.only(
            left:  leadingPadding,
            top: 17,
            bottom: 12,
            right: disableActionPadding ? 0 : 20),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 44),
              child: Row(
                children: [
                  canPop && autoImplyLeading
                      ? AppInkWell(
                          borderRadius: 30,
                          onTap: canPop ? Get.back : null,
                          child: const SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: AppSvgAsset(
                                  "assets/images/arrow_back.svg",
                                  fit: BoxFit.contain),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  if (leadingLeftPadding)
                    SizedBox(
                      width: autoImplyLeading
                          ? AppSpacings.xxMedium
                          : AppSpacings.xSmall,
                    ),
                  leading ?? const SizedBox(),
                  titleWidget != null
                      ? const SizedBox(
                          width: AppSpacings.small16,
                        )
                      : const SizedBox(),
                  titleWidget ??
                      Text(
                        title,
                        style: AppTextStyles.appBarTitle,
                      ),
                  isDialogue ? const Spacer() : const SizedBox(),
                  action != null ? const Spacer() : const SizedBox(),
                  action ?? const SizedBox(),
                  isDialogue
                      ? GestureDetector(
                          onTap: canPop
                              ? () {
                                  onClose?.call();
                                  Get.back();
                                }
                              : null,
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white),
                            child: const Center(child: Icon(Icons.close)),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            if (showSearch)
              const SizedBox(
                height: 13,
              ),
            if (showSearch)
              Container(
                margin: disableActionPadding
                    ? const EdgeInsets.only(
                        right: 20,
                      )
                    : null,
                decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadii.xSmall),
                    border: Border.all(color: AppColors.border, width: 1)),
                height: 44,
                child: Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16 + 9,
                      padding: const EdgeInsets.only(right: 9),
                      margin: const EdgeInsets.only(
                        top: 7,
                        bottom: 7,
                        right: 9,
                        left: 14,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color:
                                      AppColors.white.withOpacity(0.5)))),
                      child: AppSvgAsset(
                        "assets/images/ic_search.svg",
                        fit: BoxFit.contain,
                        color: AppColors.white.withOpacity(0.5),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white.withOpacity(0.5),
                            ),
                            hintText: "Search"),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
