class Post {
  String id;
  String title;
  String description;
  final List<String>? mediaList;
  String? mediaType; // image / video
  String postedBy;
  String postedByRole;
  String date;
  String time;
  String eventType;
  String targetAudience;
  String? classSection;
  int likes;
  int comments;
  String? eventDate;

  Post({
    required this.id,
    required this.title,
    required this.description,
    this.mediaList,
    this.mediaType,
    required this.postedBy,
    required this.postedByRole,
    required this.date,
    required this.time,
    required this.eventType,
    required this.targetAudience,
    this.classSection,
    required this.likes,
    required this.comments,
    this.eventDate,
  });
}