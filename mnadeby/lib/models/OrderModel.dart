class OrderModel{
  int? orderNumber;
  String? orderAddress;
  String? orderOwnerName;
  String? orderOwnerNumber;
  String? orderNewOwnerName;
  String? orderNewOwnerNumber;
  String? mandobName;
  double? deliveryPrice;
  String? location;
  String? date;
  String status = "لم يتم التوصيل";
  String? mandobId;

  OrderModel({
      required this.orderNumber,
      required this.orderAddress,
      required this.orderOwnerName,
      required this.orderOwnerNumber,
      required this.orderNewOwnerName,
      required this.orderNewOwnerNumber,
      required this.mandobName,
      required this.deliveryPrice,
    required this.date,
    this.location,
    required this.mandobId
  });

  OrderModel.fromJson(Map<String,dynamic>json){
    orderNumber = json['orderNumber'];
    orderAddress = json['orderAddress'];
    orderOwnerName = json['orderOwnerName'];
    orderOwnerNumber = json['orderOwnerNumber'];
    orderNewOwnerName = json['orderNewOwnerName'];
    orderNewOwnerNumber = json['orderNewOwnerNumber'];
    mandobName = json['mandobName'];
    deliveryPrice = json['deliveryPrice'];
    location = json['location'];
    date = json['date'];
    status = json['status'];
    mandobId = json['mandobId'];
  }

  Map<String,dynamic>toMap(){
    return {
      'orderNumber':orderNumber,
      'orderAddress':orderAddress,
      'orderOwnerName':orderOwnerName,
      'orderOwnerNumber':orderOwnerNumber,
      'orderNewOwnerName':orderNewOwnerName,
      'orderNewOwnerNumber':orderNewOwnerNumber,
      'mandobName':mandobName,
      'deliveryPrice':deliveryPrice,
      'location':location,
      'date':date,
      'status':status,
      'mandobId':mandobId
    };
  }

}