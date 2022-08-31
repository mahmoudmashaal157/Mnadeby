class MandobInfoModel {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? uId;
  String? image;

  MandobInfoModel(
      {required this.name,
      required this.phone,
      required this.password,
      required this.email,
      required this.uId,
      required this.image
      });

  MandobInfoModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    uId = json['uId'];
    image = json['image'];
  }
  Map<String,dynamic>toMap(){
    return {
      "name":name,
      "email":email,
      "phone":phone,
      "password":password,
      "uId":uId,
      "image":image
    };
  }
}
