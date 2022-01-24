class followClass {
  late String? senderMail;
  late String senderusername;
  late String userMail;
  late String addedMail;
  late String pid;

  followClass({required this.addedMail, required this.senderMail, required this.senderusername, required this.userMail, required this.pid});

  Map<String, dynamic> toJson() {
    return {

      'pid' : pid,
      'senderMail': senderMail,
      'senderusername': senderusername,
      'userMail': userMail,
      'addedMail': addedMail,
    };
  }

}