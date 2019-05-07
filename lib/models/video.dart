class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.title, this.thumb, this.channel});

//estamos criando um factory para retornar um json com os dados que queremos montar um objeto
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        thumb: json['snippet']['thumbnails']['high']['url'],
        channel: json['snippet']['channelTitle']);
  }
}
