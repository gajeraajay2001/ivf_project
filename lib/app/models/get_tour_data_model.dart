class GetTourDataModel {
  Tour? tour;
  bool? response;
  int? statusCode;

  GetTourDataModel({this.tour, this.response, this.statusCode});

  GetTourDataModel.fromJson(Map<String, dynamic> json) {
    tour = json['tour'] != null ? new Tour.fromJson(json['tour']) : null;
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tour != null) {
      data['tour'] = this.tour!.toJson();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Tour {
  List<Steps>? steps = [];
  String? userDbId;
  bool? isCompleted;
  String? createdOn;

  Tour({this.steps, this.userDbId, this.isCompleted, this.createdOn});

  Tour.fromJson(Map<String, dynamic> json) {
    if (json['steps'] != null) {
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    userDbId = json['user_db_id'];
    isCompleted = json['is_completed'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    data['user_db_id'] = this.userDbId;
    data['is_completed'] = this.isCompleted;
    data['created_on'] = this.createdOn;
    return data;
  }
}

class Steps {
  int? step;
  bool? isCompleted;
  String? title;

  Steps({this.step, this.isCompleted, this.title});

  Steps.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    isCompleted = json['is_completed'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step'] = this.step;
    data['is_completed'] = this.isCompleted;
    data['title'] = this.title;
    return data;
  }
}
