class Post {
  String text;
  String date;
  int likeCount;
  int commentCount;

  Post({
    required this.text,
    required this.date,
    required this.likeCount,
    required this.commentCount
  });

  @override
  String toString() => 'Post: $text\nDate: $date\nLikes: $likeCount\nComments: $commentCount';
}