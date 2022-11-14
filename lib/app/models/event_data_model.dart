class EventDataModel {
  List<Events>? events = [];
  bool? response;
  int? statusCode;

  EventDataModel({this.events, this.response, this.statusCode});

  EventDataModel.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {

      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Events {
  String? id;
  String? title;
  String? thumbnail;

  Events({this.id, this.title, this.thumbnail});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}