
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';


class ContactList extends StatefulWidget {
  final List<Contact> contacts;
  final Function onSubmitFunction;
  ContactList(
      {super.key, required this.contacts, required this.onSubmitFunction});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact> _selectedContacts = [];
  List<Contact> _filterContacts = [];
  TextEditingController controller = TextEditingController();

  void _toggleContactSelection(Contact contact) {
    setState(() {
      if (_selectedContacts.contains(contact)) {
        _selectedContacts.remove(contact);
      } else {
        _selectedContacts.add(contact);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterContacts = widget.contacts;
  }

  void _filterContactsFunc() {
    String query = controller.text.toLowerCase();
    setState(() {
      _filterContacts = widget.contacts.where((contact) {
        final String? contactName = contact.displayName?.toLowerCase();
        final String contactNumber = contact.phones!.isNotEmpty
            ? contact.phones.first.number.replaceAll(RegExp(r'\D'), '') // remove non-digits
            : '';

        return (contactName != null && contactName.contains(query)) ||
            contactNumber.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.contacts.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CustomAppBar(
                    appBarName: "Contacts to send",
                    isTextield: true,
                    textEditingController: controller,
                    onChangeFunction: (va) {
                      _filterContactsFunc();
                    },
                    actionWidget: [
                      if (_selectedContacts.isNotEmpty)
                        customTextButton("Send", onTap: () {
                          
                       widget.  onSubmitFunction(_selectedContacts);
                        Navigator.pop(context);
                      
                        })
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _filterContacts.length,
                      itemBuilder: (context, index) {
                        final contact = _filterContacts[index];
                        print("contactList is here$contact");
                        return
                         ContactListCard(
                          avatar: contact.thumbnail,
                          contactName: contact.displayName ?? '',
                          value: _selectedContacts.contains(contact),
                          onCange: () {
                            _toggleContactSelection(contact);
                            if (controller.text.isNotEmpty) {
                              controller.clear();
                              _filterContactsFunc();
                            }
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) => customDivider(),
                    ),
                  ),
                  if (_selectedContacts.isNotEmpty)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120.h,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border(),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedContacts.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ReusableAvatarWithIcon(
                              profileImage:_selectedContacts[index].thumbnail?.isEmpty==true ||_selectedContacts[index].thumbnail==null?AssetImage("assets/images/empty_small_image.png"):
                                  MemoryImage(_selectedContacts[index].thumbnail!),
                              showIcon: true,
                              iconWidget: Positioned(
                                right: 0,
                                child: CustomCircleIconWidget(
                                  onCange: () {
                                    _toggleContactSelection(
                                        _selectedContacts[index]);
                                  },
                                  backgroundClr: AppColors.secondary,
                                  iconData: Icons.close,
                                  iconColor: AppColors.white,
                                ),
                              ),
                              iconAlignment: Alignment.bottomRight,
                            ),
                            SizedBox(
                                width: 70.w,
                                child: Text(
                                  _selectedContacts[index].displayName ?? "",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ))
                          ],
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
