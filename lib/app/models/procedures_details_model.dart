import 'package:get/get.dart';

import '../constants/api_constant.dart';

class ProcedureDetailModel {
  Procedure? procedure;
  bool? response;
  int? statusCode;

  ProcedureDetailModel({this.procedure, this.response, this.statusCode});

  ProcedureDetailModel.fromJson(Map<String, dynamic> json) {
    procedure = json['procedure'] != null
        ? Procedure.fromJson(json['procedure'])
        : null;
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.procedure != null) {
      data['procedure'] = this.procedure!.toJson();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Procedure {
  String? id;
  List<Detail>? detail;
  String? name;
  String? description;
  ProcedureType? procedureType;
  int? noOfPatients;

  Procedure(
      {this.id,
      this.detail,
      this.name,
      this.description,
      this.procedureType,
      this.noOfPatients});

  Procedure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
    name = json['name'];
    description = json['description'];
    procedureType = json['procedure_type'] != null
        ? new ProcedureType.fromJson(json['procedure_type'])
        : null;
    noOfPatients = json['no_of_patients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.procedureType != null) {
      data['procedure_type'] = this.procedureType!.toJson();
    }
    data['no_of_patients'] = this.noOfPatients;
    return data;
  }
}

class Detail {
  int? day;
  String? date;
  bool? isToday;
  List<Events>? events;

  Detail({this.day, this.date, this.isToday, this.events});

  Detail.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    isToday = json['is_today'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['is_today'] = this.isToday;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? eventDbId;
  String? eventName;
  String? additionalInstruction;
  bool? isVisible;
  List<String>? uploads;
  RxBool? isActive;
  RxString? image;
  Events(
      {this.eventDbId,
      this.eventName,
      this.additionalInstruction,
      this.isVisible,
      this.image,
      this.isActive,
      this.uploads});

  Events.fromJson(Map<String, dynamic> json) {
    eventDbId = json['event_db_id'];
    eventName = json['event_name'];
    additionalInstruction = json['additional_instruction'];
    isVisible = json['is_visible'];

    isActive = false.obs;
    image = getImageById(id: eventDbId!).obs;
    if (json['uploads'] != null) {
      json['uploads'].forEach((v) {
        uploads!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_db_id'] = this.eventDbId;
    data['event_name'] = this.eventName;
    data['additional_instruction'] = this.additionalInstruction;
    data['is_visible'] = this.isVisible;
    if (this.uploads != null) {
      data['uploads'] = this.uploads!.map((v) => v).toList();
    }
    return data;
  }
}

class ProcedureType {
  String? id;
  String? title;

  ProcedureType({this.id, this.title});

  ProcedureType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
