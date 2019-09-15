class Media {
  int id;
  String url;
  String mediaType;
  int contentId;
  String contentType;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Media({
    this.id,
    this.url,
    this.mediaType,
    this.contentId,
    this.contentType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => new Media(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        mediaType: json["media_type"] == null ? null : json["media_type"],
        contentId: json["content_id"] == null ? null : json["content_id"],
        contentType: json["content_type"] == null ? null : json["content_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "media_type": mediaType == null ? null : mediaType,
        "content_id": contentId == null ? null : contentId,
        "content_type": contentType == null ? null : contentType,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
