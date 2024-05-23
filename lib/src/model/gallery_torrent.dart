import 'base_model.dart';

class GalleryTorrent extends Model<GalleryTorrent> {
  String title;
  String postTime;
  String size;
  int seeds;
  int peers;
  int downloads;
  String uploader;
  String torrentUrl;
  String magnetUrl;
  bool outdated;

  GalleryTorrent({
    required this.title,
    required this.postTime,
    required this.size,
    required this.seeds,
    required this.peers,
    required this.downloads,
    required this.uploader,
    required this.torrentUrl,
    required this.magnetUrl,
    required this.outdated,
  });

  @override
  GalleryTorrent fromJson(Map<String, dynamic> map) {
    title = map['title'];
    postTime = map['postTime'];
    size = map['size'];
    seeds = map['seeds'];
    peers = map['peers'];
    downloads = map['downloads'];
    uploader = map['uploader'];
    torrentUrl = map['torrentUrl'];
    magnetUrl = map['magnetUrl'];
    outdated = map['outdated'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['postTime'] = postTime;
    data['size'] = size;
    data['seeds'] = seeds;
    data['peers'] = peers;
    data['downloads'] = downloads;
    data['uploader'] = uploader;
    data['torrentUrl'] = torrentUrl;
    data['magnetUrl'] = magnetUrl;
    data['outdated'] = outdated;
    return data;
  }
}
