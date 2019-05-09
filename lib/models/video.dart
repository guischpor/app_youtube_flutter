class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.title, this.thumb, this.channel});

//estamos criando um factory para retornar um json com os dados que queremos montar um objeto
//esses dados são pegos do servidor da google e criado a factory
  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id'))
      return Video(
          id: json['id']['videoId'],
          title: json['snippet']['title'],
          thumb: json['snippet']['thumbnails']['high']['url'],
          channel: json['snippet']['channelTitle']);
    else {
      //retorna o tipo json que realmente queremos para salvar na lista de favs
      return Video(
          id: json['id'],
          title: json['title'],
          thumb: json['thumb'],
          channel: json['channel']);
    }
  }

  //criando a lista de favoritos em json
  Map<String, dynamic> toJson() {
    return {'videoId': id, 'title': title, 'thumb': thumb, 'channel': channel};
  }
}
