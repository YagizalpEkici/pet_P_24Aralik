class reportclass {
  late String reportedMail;
  late String pid;
  late String postid;


  reportclass({required this.postid, required this.reportedMail, required this.pid});

  Map<String, dynamic> toJson() {
    return {

      'pid' : pid,
      'reportedMail': reportedMail,
      'postid': postid

    };
  }

}