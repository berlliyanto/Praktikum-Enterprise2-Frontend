class userModel{
  late String? username,name,password,tanggal,level,id;
  
  userModel({this.id,this.level, this.name, this.password, this.tanggal, this.username});

  factory userModel.FromJSON(Map<String, dynamic> json){
    return userModel(
      id: json['iduser'],
      username: json['username'],
      password: json['password'],
      level: json['level'],
      name: json['nama'],
      tanggal: json['tanggal']
    );
  }
}