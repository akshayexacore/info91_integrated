
 import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:info91/src/models/user.dart';
class Variables{
  static   List<Contact> userContact=[];
 static  User? user = User();


 static void clear() {
    userContact.clear(); // Clears the list
    user = null;         // Sets the user model to null
  }
}