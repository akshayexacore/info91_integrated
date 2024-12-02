import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/forward/controllers/forward_controller.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_profile_tile.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ForwardPage extends StatefulWidget {
  ForwardPage({super.key});

  static const routeName = '/forward';

  @override
  State<ForwardPage> createState() => _ForwardPageState();
}

class _ForwardPageState extends State<ForwardPage> {
  final _controller = Get.find<ForwardController>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppAppBar(
            onchange: (String value){
              _controller.searchFunction(value??"");
            },
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
                      onTap: enableButton ? _controller.onSend : null,
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
              debugPrint(_controller.filtercontacts.toString());
              return _controller.filtercontacts.isEmpty?_controller.searchValue.isNotEmpty?noDataDesighn( "No Result found for \"${_controller.searchValue.value}\""):Text("No data"):                         
              ListView.builder(
                 itemCount: _controller.filtercontacts.length,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  // final key = _controller.contacts.keys.elementAt(index);
                  final profiles = _controller.filtercontacts[index];
                  return  Obx(() {
                    debugPrint(_controller.filtercontacts[index].toString());
                            return AppProfileTile(
                              profiles,
                              onPressed: () {
                                _controller.onSelectedContact(profiles);
                              },
                              enableCheckbox: true,
                              selected: _controller.selectedContacts
                                  .contains(profiles),
                            );
                          
                });
               
                }
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

  Widget noDataDesighn(String message){return Padding(
    padding:  EdgeInsets.symmetric(vertical: 20.h),
    child: Text(message,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.sp),),
  );}

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
         WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_controller. scrollController.hasClients) {
        _controller .   scrollController.animateTo(
          _controller .scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.large,
          ),
          scrollDirection: Axis.horizontal,
           controller:_controller.scrollController, 
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
                              image: _controller.selectedContacts[index].profileImage??"",
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
                      _controller.selectedContacts[index].groupName??"".split(' ').first,
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
