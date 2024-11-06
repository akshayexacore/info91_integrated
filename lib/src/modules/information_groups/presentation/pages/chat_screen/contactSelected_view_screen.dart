import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

import 'package:url_launcher/url_launcher.dart';

class SelectedContactListView extends StatelessWidget {
  final List<ContactModel> contactList;
  const SelectedContactListView({super.key, required this.contactList});
  void saveContact(ContactModel contact) async {
    final String url = 'tel:${contact.displayName}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future<void> saveNewContact(BuildContext context) async {
  //   // await requestContactPermission(); // Ensure permission is granted

  //   Contact newContact = Contact(
  //     givenName: "John",
  //     familyName: "Doe",
  //     phones: [Item(label: "mobile", value: "+123456789")],
  //   );
  //   // await Flutterc.addContact(newContact);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('New contact saved successfully!')),
  //   );
  // }
  Future<void> saveToExistingContact(String phoneNumber) async {
  final Uri url = Uri(
    scheme: 'tel',  // This will open the phone dialer app
    path: phoneNumber,  // This is the phone number you want to add
  );

  if (await canLaunchUrl(url)) {
    // Launch the phone's native contact app to add to an existing contact
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

  // Future<void> saveToExistingContact(BuildContext context) async {
  //   Iterable<Contact> contacts = await ContactsService.getContacts();
  //   if (contacts.isNotEmpty) {
  //     Contact existingContact = contacts.first;
  //     existingContact.phones = [
  //       ...?existingContact.phones,
  //       Item(label: "mobile", value: "+123456789"), // Adding a new number
  //     ];

  //     await ContactsService.updateContact(existingContact);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Phone number added to existing contact!')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('No contacts found!')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        CustomAppBar(appBarName: "View Contacts"),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => Column(
                      children: [
                        ContactListCard(
                          onCange: () {},
                          avatar: contactList[index].thumbnail ?? Uint8List(0),
                          contactName: contactList[index].displayName ?? "",
                          leadingWidget: AppButton(
                            text: "Adds",
                            width: 60,
                            onPressed: () {
                              // AppDialog.showDialog(
                              //     content: "crea",
                              //     positiveText: "new",
                              //     negativeText: "Existing",
                              //     negativeOnPressed: () {
                              //       saveToExistingContact("9995528886");
                              //     });
                              saveContact(contactList[index]);
                            },
                            height: 30,
                            style: AppButtonStyles.appButton.copyWith(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.secondary)),
                            textStyle: AppTextStyles.appButton
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                        customDivider(),
                        ListTile(
                          leading:const  Icon(
                            Icons.message,
                            color: AppColors.primary,
                          ),
                          title: greyBoldText(
                              contactList[index].displayName ?? ""),
                        )
                      ],
                    ),
                separatorBuilder: (context, index) => Container(
                      height: 5.h,
                      color: AppColors.white,
                    ),
                itemCount: contactList.length))
      ],
    );
  }
}
