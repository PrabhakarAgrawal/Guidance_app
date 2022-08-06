class forGuide {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String college;
  final String bio;
  final List followers;
  final List following;

  forGuide(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.college,
      required this.bio,
      required this.followers,
      required this.following});
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "college": college,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
