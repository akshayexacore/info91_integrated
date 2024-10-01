

class Status {
  Status({
    this.imgUrl = '',
    this.statusCount = 0,
    this.seenIndex = 0,
    required this.name,
    this.postTime = '',
  });

  final String imgUrl;
  final int statusCount;
  final int seenIndex;
  final String name;
  final String postTime;

  static Status mine = Status(
    imgUrl:
        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
    statusCount: 4,
    seenIndex: 2,
    name: 'Prajeesh Prabhakar',
    postTime: 'Just now',
  );

  static List<Status> dummyList() => [
        Status(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          statusCount: 4,
          seenIndex: 2,
          name: 'Prajeesh Prabhakar',
          postTime: '10 minutes ago',
        ),
        Status(
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzOuEOtYScMiWM_kWau4NvafPSaIaXfo71Tp_nea7lYw&s',
          statusCount: 3,
          seenIndex: 2,
          name: 'Mohammad Rizwan',
          postTime: '20 minutes ago',
        ),
        Status(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          statusCount: 1,
          seenIndex: 0,
          name: 'Prajeesh Prabhakar',
          postTime: '40 minutes ago',
        ),
        Status(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          statusCount: 2,
          seenIndex: 0,
          name: 'Basil',
          postTime: '4 hours ago',
        ),
        Status(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          statusCount: 3,
          seenIndex: 2,
          name: 'Arya',
          postTime: '20 minutes ago',
        ),
        Status(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          statusCount: 1,
          seenIndex: 0,
          name: 'Deepak',
          postTime: '4 hours ago',
        ),
      ];

  static List<Status> dummyListSeen() => [
        Status(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          statusCount: 4,
          seenIndex: 4,
          name: 'Virat',
          postTime: '6 hours ago',
        ),
        Status(
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzOuEOtYScMiWM_kWau4NvafPSaIaXfo71Tp_nea7lYw&s',
          statusCount: 3,
          seenIndex: 3,
          name: 'Sachin',
          postTime: '4 hours ago',
        ),
        Status(
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          statusCount: 1,
          seenIndex: 1,
          name: 'Tovino',
          postTime: '20 minutes ago',
        ),
      ];
}
