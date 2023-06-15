class WebinarsModel{
  late var id, title, image, short_description, long_description, timing, expiration, duration, link, created_by, status, meeting_id, meeting_password, created_at, updated_at;
  WebinarsModel(
      {required this.id,
        this.title,
        this.image,
        this.short_description,
        this.long_description,
        this.timing,
        this.expiration,
        this.duration,
        this.link,
        this.created_by,
        this.status,
        this.meeting_id,
        this.meeting_password,
      });
}