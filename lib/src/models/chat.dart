enum MessageStatus {
  none,
  sending,
  sent,
  delivered,
  seen,
}

class Chat {
  String message;
  bool own;
  MessageStatus status;
  String time;
  String reaction;
  int id;
  bool starred;
  bool deleted;
  DateTime date;

  Chat({
    this.message = '',
    this.own = false,
    this.status = MessageStatus.none,
    this.time = '',
    this.reaction = '',
    this.id = 0,
    this.starred = false,
    this.deleted = false,
    required this.date,
  });

  Chat copyWith({
    String? message,
    bool? own,
    MessageStatus? status,
    String? time,
    String? reaction,
    int? id,
    bool? starred,
    DateTime? date,
  }) {
    return Chat(
      message: message ?? this.message,
      own: own ?? this.own,
      status: status ?? this.status,
      time: time ?? this.time,
      reaction: reaction ?? this.reaction,
      id: id ?? this.id,
      starred: starred ?? this.starred,
      date: date ?? this.date,
    );
  }

  static List<Chat> dummyList() => [
        Chat(
          id: 1,
          message: 'I\'m from Russia.',
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 2,
          message: 'What about you..?',
          own: true,
          deleted: true,
          status: MessageStatus.sent,
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 3,
          message: 'I\'m from Turkey.',
          own: true,
          status: MessageStatus.delivered,
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 4,
          message: 'Where are you from?',
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 5,
          message: 'It\'s Joe',
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 6,
          message: 'What\'s your name?',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 7,
          message: 'I\'m Jason.',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 8,
          message: 'What\'s ur name.?',
          date: DateTime.parse('2024-06-20'),
        ),
        Chat(
          id: 9,
          message: 'Hello',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 10,
          message: 'Hi',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 11,
          message: 'I\'m from Russia.',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 12,
          message: 'What about you..?',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 13,
          message: 'I\'m from Turkey.',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 14,
          message: 'Where are you from............????????',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 15,
          message: 'It\'s Joe',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 16,
          message: 'What\'s your name?',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 17,
          message: 'I\'m Jason.',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 18,
          message: 'What\'s ur name.?',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 12,
          message: 'What about you..?',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 13,
          message: 'I\'m from Turkey.',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 14,
          message: 'Where are you from............????????',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 15,
          message: 'It\'s Joe',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 16,
          message: 'What\'s your name?',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 17,
          message: 'I\'m Jason.',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 18,
          message: 'What\'s ur name.?',
          date: DateTime.parse('2024-06-18'),
        ),
        Chat(
          id: 19,
          message: 'Hello',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-15'),
        ),
        Chat(
          id: 20,
          message: 'Hi',
          date: DateTime.parse('2024-06-15'),
        ),
        Chat(
          id: 21,
          message: 'Hello',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-15'),
        ),
        Chat(
          id: 22,
          message: 'Hi',
          date: DateTime.parse('2024-06-15'),
        ),
        Chat(
          id: 23,
          message: 'Hello',
          own: true,
          status: MessageStatus.seen,
          date: DateTime.parse('2024-06-15'),
        ),
        Chat(
          id: 24,
          message: 'Hi',
          date: DateTime.parse('2024-06-15'),
        ),
      ];
}
