import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  List<Datum> data;

  UserData({
    required this.data,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int dayCount;
  String days;
  Status status;
  int hourCount;

  Datum({
    required this.dayCount,
    required this.days,
    required this.status,
    required this.hourCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    dayCount: json["dayCount"],
    days: json["days"],
    status: statusValues.map[json["status"]]!,
    hourCount: json["hourCount"],
  );

  Map<String, dynamic> toJson() => {
    "dayCount": dayCount,
    "days": days,
    "status": statusValues.reverse[status],
    "hourCount": hourCount,
  };
}

enum Status {
  absent,
  present,
  sickLeave,
  status
}

final statusValues = EnumValues({
  "Absent": Status.absent,
  "Present": Status.present,
  "Sick Leave": Status.sickLeave,
  "Status": Status.status
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

extension StatusValue on Status{
  get stringValue=>switch(this){
    Status.absent=>"Absent",
    Status.present=>"Present",
    Status.status=>"Invalid",
    Status.sickLeave=>"Sick Leave",
  };
}
