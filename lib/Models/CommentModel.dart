class CommentModel {
  CommentModel({
    required this.postid,
    required this.uid,
    required this.text,
  });
  late final String postid;
  late final String uid;
  late final String text;

  CommentModel.fromJson(Map<String, dynamic> json){
    postid = json['postid'];
    uid = json['uid'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['postid'] = postid;
    _data['uid'] = uid;
    _data['text'] = text;
    return _data;
  }
}