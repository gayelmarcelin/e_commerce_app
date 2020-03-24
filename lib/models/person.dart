class Personne {
  String userId;
  String email;
  String userName;
  String gender;
  String password;

  Personne({this.userId, this.email, this.userName,this.gender,this.password});

  Personne.fromMap(Map snapshot,String id) :
        userId = id ?? '',
        email = snapshot['email'] ?? '',
        userName = snapshot['userName'] ?? '',
        gender = snapshot['gender'] ?? '',
        password = snapshot['password'] ?? '';

  toJson() {
    return {
      "userid": userId,
      "userName": userName,
      "gender": gender,
      "password": password,
      "email": email,
    };
  }
}