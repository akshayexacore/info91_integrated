import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/recipients/controllers/recipients_add_controller.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_profile_tile.dart';

class RecipientsAddPage extends StatelessWidget {
  RecipientsAddPage({super.key});

  static const routeName = '/recipients_add';

  final RecipientsAddController _controller =
      Get.find<RecipientsAddController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          AppAppBar(
            showSearch: true,
            leading: const Text(
              'Recipients',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            action: Obx(() {
              final enableButton = _controller.selectedContacts.isNotEmpty;
              return AppInkWell(
                onTap: enableButton ? _controller.onDonePressed : null,
                child: Text(
                  'Done',
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
          ),
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
          Container(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppPaddings.small,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPaddings.large,
                  ),
                  child: Text(
                    'Only 3 recipients can add',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                ..._controller.selectedProfiles
                    .map((profile) => AppProfileTile(
                          profile,
                          enableClose: true,
                        ))
                    .toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
