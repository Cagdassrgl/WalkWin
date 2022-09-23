class ActivityModel {
  String? activityName;
  int? activityDuration;
  double? activityDistance;
  List<dynamic>? geoPointList;

  ActivityModel(
      {this.activityName,
      this.activityDuration,
      this.activityDistance,
      this.geoPointList});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    activityDuration = json['activityDuration'];
    activityDistance = json['activityDistance'];
    geoPointList = json['polylineCoordinates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['activityDuration'] = activityDuration;
    data['activityDistance'] = activityDistance;
    data['polylineCoordinates'] = geoPointList;
    return data;
  }
}
