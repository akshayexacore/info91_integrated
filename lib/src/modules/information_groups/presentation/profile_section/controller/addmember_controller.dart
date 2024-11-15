import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/contact_model.dart';

import 'package:info91/src/resources/infromation_repository.dart';

class AddmemberController extends GetxController {
  final _infromationRepository = InfromationRepository();
  var selectedContacts = <ContactAddGroupModel>[].obs;
  var filterContacts = <ContactAddGroupModel>[].obs;
  var existingContacts = <ContactAddGroupModel>[].obs;
  var nonexistingContacts = <ContactAddGroupModel>[].obs;
  TextEditingController controller = TextEditingController();
  String selectedGroupId = "";

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['group_id'] != selectedGroupId) {
        selectedGroupId = Get.arguments['group_id'] ?? '';
        fetchInfo91Contacts();
      } else {
        debugPrint('No group data found in Get.arguments');
      }
    }

    super.onInit();
  }

  Future<void> fetchInfo91Contacts() async {
    try {
      final response = await _infromationRepository.fetchInfo91Contacts(
        selectedGroupId,
      );
      if (response != null) {
        filterContacts.value = response;
        existingContacts.value =
            filterContacts.where((contact) => contact.exists == true).toList();
        nonexistingContacts.value =
            filterContacts.where((contact) => contact.exists == false).toList();
      }
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  void toggleContactSelection(ContactAddGroupModel contact) {
    if (selectedContacts.contains(contact)) {
      selectedContacts.remove(contact);
    } else {
      selectedContacts.add(contact);
    }
  }

  void filterContactsFunc() {
    String query = controller.text.toLowerCase();

    final filterContacts1 = filterContacts.where((contact) {
      final String? contactName = contact.displayName?.toLowerCase();
      final String contactNumber = contact.formattedNumber!.isNotEmpty
          ? contact.formattedNumber ?? "" // remove non-digits
          : '';

      return (contactName != null && contactName.contains(query)) ||
          contactNumber.contains(query);
    }).toList();
    existingContacts.value =
        filterContacts1.where((contact) => contact.exists == true).toList();
    nonexistingContacts.value =
        filterContacts1.where((contact) => contact.exists == false).toList();
  }

  Future<void> addToGroup() async {
    try {
      final response = await _infromationRepository.addToGroup(selectedGroupId,
          selectedContacts.map((e) => e.userId ?? "").toList());
      if (response.data1) {
           Get.back();
        //  Get.snackbar("Success", response.data2);
      
      } else {
        Get.snackbar("error", response.data2);
      }
    } catch (e) {
   
    }
  }
}
