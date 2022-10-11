class DataUserModel {
  int? uid;
  String? MDU;
  String? fname;
  String? lname;
  String? lat;
  String? lng;

  DataUserModel({this.uid, this.MDU, this.fname, this.lname,this.lat,this.lng});

  DataUserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    MDU = json['MDU'];
    fname = json['fname'];
    lname = json['lname'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['MDU'] = MDU;
    data['fname'] = fname;
    data['lname'] = lname;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
