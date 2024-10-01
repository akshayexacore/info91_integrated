import 'package:info91/src/models/chat.dart';

class Profile {
  Profile({
    this.id = 0,
    this.imgUrl = '',
    this.lastMessage = '',
    this.messageStatus = MessageStatus.none,
    required this.name,
    this.lastMessageTime = '',
    this.about = '',
  });

  final int id;
  final String imgUrl;
  final String lastMessage;
  final MessageStatus messageStatus;
  final String name;
  final String lastMessageTime;
  final String about;

  static List<Profile> dummyList() => [
        Profile(
            id: 1,
            imgUrl:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            lastMessage: 'How are you doing today?',
            messageStatus: MessageStatus.seen,
            name: 'Prajeesh Prabhakar',
            lastMessageTime: '4:20 PM',
            about: 'Turning ordinary into extraordinary'),
        Profile(
            id: 2,
            imgUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzOuEOtYScMiWM_kWau4NvafPSaIaXfo71Tp_nea7lYw&s',
            lastMessage: 'Have a nice day',
            messageStatus: MessageStatus.delivered,
            name: 'Mohammad Rizwan',
            lastMessageTime: '4:10 PM',
            about: 'Creating my own sunshine in a world'),
        Profile(
          id: 3,
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          lastMessage: 'Good Morning',
          messageStatus: MessageStatus.sent,
          name: 'Prajeesh Prabhakar',
          lastMessageTime: '4:20 PM',
        ),
        Profile(
            id: 4,
            imgUrl:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            lastMessage: 'How are you doing today?',
            messageStatus: MessageStatus.seen,
            name: 'Prajeesh Prabhakar',
            lastMessageTime: '4:20 PM',
            about: 'Living my story, one status at a time'),
        Profile(
            id: 5,
            imgUrl:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            lastMessage: 'How are you doing today?',
            messageStatus: MessageStatus.seen,
            name: 'Prajeesh Prabhakar',
            lastMessageTime: '4:20 PM',
            about: 'Not perfect, but always real'),
        Profile(
            id: 6,
            imgUrl:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            lastMessage: 'How are you doing today?',
            messageStatus: MessageStatus.seen,
            name: 'Prajeesh Prabhakar',
            lastMessageTime: '4:20 PM',
            about: 'Not perfect, but always real'),
      ];
}
