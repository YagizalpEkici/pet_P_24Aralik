class followStatusClass {
  late String? senderMail;
  late String userMail;
  late String pid;
  late String addedMail;
  late bool followButtonInitial;
  late bool pending;
  late bool followAccepted;
  late bool unfollow;

  followStatusClass({required this.addedMail, required this.senderMail, required this.userMail, required this.pid, required this.pending, required this.followAccepted, required this.followButtonInitial, required this.unfollow});

  Map<String, dynamic> toJson() {
    return {

      'pid' : pid,
      'senderMail': senderMail,
      'userMail': userMail,
      'addedMail': addedMail,
      'followButtonInitial': followButtonInitial,
      'pending': pending,
      'followAccepted': followAccepted,
      'unfollow': unfollow
    };
  }

}