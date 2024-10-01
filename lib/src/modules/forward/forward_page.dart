import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/forward/controllers/forward_controller.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_profile_tile.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ForwardPage extends StatelessWidget {
  ForwardPage({super.key});

  static const routeName = '/forward';

  final _controller = Get.find<ForwardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppAppBar(
              showSearch: true,
              leading: const Text(
                'Forward',
                style: TextStyle(
                  fontSize: AppFontSizes.small15,
                  color: AppColors.white,
                ),
              ),
              titleWidget: Obx(
                () {
                  return Text(
                    '${_controller.selectedContacts.length}/${_controller.contactsLength}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: AppFontSizes.xSmall,
                    ),
                  );
                },
              ),
              action: Row(
                children: [
                  Obx(() {
                    final enableButton =
                        _controller.selectedContacts.isNotEmpty;
                    return AppInkWell(
                      onTap: enableButton ? _controller.onSendPressed : null,
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontSize: AppFontSizes.small15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white.withOpacity(
                            enableButton ? 1 : 0.5,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              )),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  final key = _controller.contacts.keys.elementAt(index);
                  final profiles = _controller.contacts.values.elementAt(index);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPaddings.large,
                        ),
                        child: SizedBox(
                          width: 48,
                          child: Center(
                            child: Text(
                              key,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...profiles
                          .map((profile) => Obx(() {
                                return AppProfileTile(
                                  profile,
                                  onPressed: () {
                                    _controller.onSelectedContact(profile);
                                  },
                                  enableCheckbox: true,
                                  selected: _controller.selectedContacts
                                      .contains(profile),
                                );
                              }))
                          .toList()
                    ],
                  );
                },
                itemCount: _controller.contacts.length,
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return _controller.selectedContacts.isNotEmpty
            ? _buildSelectedContacts()
            : const SizedBox();
      }),
    );
  }

  Widget _buildSelectedContacts() {
    return Container(
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(7, 0),
            blurRadius: 7,
            color: AppColors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Obx(() {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.large,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Center(
              child: SizedBox(
                width: 54,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppInkWell(
                      borderRadius: 54,
                      onTap: () {
                        _controller.onSelectedContact(
                            _controller.selectedContacts[index]);
                      },
                      child: SizedBox(
                        height: 54,
                        child: Stack(
                          children: [
                            AppCircleImage(
                              image: _controller.selectedContacts[index].imgUrl,
                              radius: 20,
                            ),
                            const Positioned(
                              right: 0,
                              top: 0,
                              child: AppSvgAsset(
                                'assets/images/ic_close.svg',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      _controller.selectedContacts[index].name.split(' ').first,
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: _controller.selectedContacts.length,
          separatorBuilder: (context, index) => const SizedBox(
            width: AppSpacings.medium,
          ),
        );
      }),
    );
  }
}
