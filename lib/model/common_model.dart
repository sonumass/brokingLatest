class CommonModel{
  CommonModel({
    required this.message,
    required this.status,
   });

  CommonModel.fromJson(dynamic json) {
    message = json['message']??"";
    status = json['status']??"200";

  }
  String message="";
  String status="200";


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;

    return map;
  }

}