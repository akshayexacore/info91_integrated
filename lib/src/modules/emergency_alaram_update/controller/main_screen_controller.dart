import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';

class MainController extends GetxController {
    var locationMessage = "koratty, Thrissur, Kerala".obs;
  var groupsList = [
    Groupmodel(
        imageUrl:
            'https://s3-alpha-sig.figma.com/img/3ccd/3c80/b824c0f0656c4b3dbf063147cda4ea28?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZCOoOYVMSKpbf~yYMEebuCicFLN075nl1bTxyqgeHZ1Km-64Uo0ZYt4DnoVEuiTbXPqU49daYo7LneO9cQVX63WgR2cLd4lfroT8DHHcQPpws6X~uErHJ6RZvcJ6vMPe1MIDdXI~DktSIaLqWwYmWmSioiFj~aqA4ZOefkXv~Byy~1ywgJw9L94Dj-783hqFaxMiMHMaZ4uDec75oT6nufhtKnhDN4afQi4fFPwEsiNsutza1s9cyyL8i1OFhvuVf0-aZK7gAW4SfPEfAFa59-Fy9YboBjLBt8tqdXxoqRpIoJizUyNzZrwai2KUhCoCqAW1mntvG~wT5F2xZl-uRg__',
        id: 1,
        membersList: ["Nick", "jas", "jose"],
        groupName: 'Office Group'),
    Groupmodel(
        imageUrl:
            'https://s3-alpha-sig.figma.com/img/3ccd/3c80/b824c0f0656c4b3dbf063147cda4ea28?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZCOoOYVMSKpbf~yYMEebuCicFLN075nl1bTxyqgeHZ1Km-64Uo0ZYt4DnoVEuiTbXPqU49daYo7LneO9cQVX63WgR2cLd4lfroT8DHHcQPpws6X~uErHJ6RZvcJ6vMPe1MIDdXI~DktSIaLqWwYmWmSioiFj~aqA4ZOefkXv~Byy~1ywgJw9L94Dj-783hqFaxMiMHMaZ4uDec75oT6nufhtKnhDN4afQi4fFPwEsiNsutza1s9cyyL8i1OFhvuVf0-aZK7gAW4SfPEfAFa59-Fy9YboBjLBt8tqdXxoqRpIoJizUyNzZrwai2KUhCoCqAW1mntvG~wT5F2xZl-uRg__',
        id: 2,
        membersList: ["Nick", "jas", "sss"],
        groupName: 'School group'),
    Groupmodel(
        imageUrl:
            'https://s3-alpha-sig.figma.com/img/3ccd/3c80/b824c0f0656c4b3dbf063147cda4ea28?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZCOoOYVMSKpbf~yYMEebuCicFLN075nl1bTxyqgeHZ1Km-64Uo0ZYt4DnoVEuiTbXPqU49daYo7LneO9cQVX63WgR2cLd4lfroT8DHHcQPpws6X~uErHJ6RZvcJ6vMPe1MIDdXI~DktSIaLqWwYmWmSioiFj~aqA4ZOefkXv~Byy~1ywgJw9L94Dj-783hqFaxMiMHMaZ4uDec75oT6nufhtKnhDN4afQi4fFPwEsiNsutza1s9cyyL8i1OFhvuVf0-aZK7gAW4SfPEfAFa59-Fy9YboBjLBt8tqdXxoqRpIoJizUyNzZrwai2KUhCoCqAW1mntvG~wT5F2xZl-uRg__',
        id: 3,
        membersList: ["Nick", "jas", "jose"],
        groupName: 'Office Group'),
  ].obs;

  var selctedGroups = <int>[].obs;




@override
  void onInit() {
    debugPrint("init state xcalling");
  //  _getCurrentLocation();
    super.onInit();
  }


  void onArchiveProfilePressed(int index) {
    debugPrint("index$index");
    if (!selctedGroups.contains(groupsList[index].id)) {
      selctedGroups.add(groupsList[index].id);
    } else {
      selctedGroups.remove(groupsList[index].id);
    }
  }

  String conversionTOString(List<String> list) {
    String returnValue = "";
    if (list.isEmpty) {
      return "";
    } else {
      if (list.length >= 3) {
        returnValue = list.take(3).join(',');
      } else {
        returnValue = list.take(list.length).join(',');
      }
    }
    return returnValue;
  }


//  Future<void> _getCurrentLocation() async {
//     // Check permissions
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // Get the current location
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
    
   
//       locationMessage.value = "Lat: ${position.latitude}, Lng: ${position.longitude}";
   
//   }

}

class Groupmodel {
  final String? imageUrl;
  final String groupName;
  final int id;
  final List<String> membersList;

  Groupmodel(
      {required this.imageUrl,
      required this.groupName,
      required this.id,
      required this.membersList});
}
