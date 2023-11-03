class Webinar {
  int? id;
  String? title;
  String? image;
  String? shortDescription;
  String? longDescription;
  String? timing;
  String? expiration;
  String? duration;
  String? link;
  String? createdBy;
  String? status;
  String? meetingId;
  String? meetingPassword;
  String? createdAt;
  String? updatedAt;

  Webinar({
    required this.id,
    required this.title,
    required this.image,
    required this.shortDescription,
    required this.longDescription,
    required this.timing,
    required this.expiration,
    required this.duration,
    required this.link,
    required this.createdBy,
    required this.status,
    required this.meetingId,
    required this.meetingPassword,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Webinar.fromJson(Map<String, dynamic> json) {
    return Webinar(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      timing: json['timing'],
      expiration: json['expiration'],
      duration: json['duration'],
      link: json['link'],
      createdBy: json['created_by'],
      status: json['status'],
      meetingId: json['meeting_id'],
      meetingPassword: json['meeting_password'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
