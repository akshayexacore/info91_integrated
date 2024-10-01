

import 'package:info91/src/models/chat.dart';

class Group {
  Group({
    this.imgUrl = '',
    this.lastMessage = '',
    this.messageStatus = MessageStatus.none,
    required this.name,
    this.lastMessageTime = '',
    this.about = '',
  });

  final String imgUrl;
  final String lastMessage;
  final MessageStatus messageStatus;
  final String name;
  final String lastMessageTime;
  final String about;

  static List<Group> dummyList() => [
        Group(
            imgUrl:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            lastMessage: 'Novena starts at 6.00..',
            messageStatus: MessageStatus.seen,
            name: 'St. Mary’s Church',
            lastMessageTime: '4:18 PM',
            about: 'Turning ordinary into extraordinary'),
        Group(
            imgUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzOuEOtYScMiWM_kWau4NvafPSaIaXfo71Tp_nea7lYw&s',
            lastMessage: '50% OFF on selected..',
            messageStatus: MessageStatus.delivered,
            name: 'More Supermarket',
            lastMessageTime: '4:10 PM',
            about: 'Creating my own sunshine in a world'),
        Group(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          lastMessage: 'Dine in at 20% OFF tod...',
          messageStatus: MessageStatus.sent,
          name: 'MRA Restaurant',
          lastMessageTime: '4:20 PM',
        ),
        Group(
            imgUrl:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            lastMessage: 'CAR for sale at 50K...',
            messageStatus: MessageStatus.seen,
            name: 'Info91 Classifieds',
            lastMessageTime: '4:20 PM',
            about: 'Living my story, one status at a time'),
        Group(
            imgUrl:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            lastMessage: 'Sona 27 Yrs, Pala, ...',
            messageStatus: MessageStatus.seen,
            name: 'Matrimony Services',
            lastMessageTime: '4:20 PM',
            about: 'Not perfect, but always real'),
      ];
}
