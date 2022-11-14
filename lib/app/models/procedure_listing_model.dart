import 'package:get/get.dart';

class ProcedureListingModel {
  List<Procedures>? procedures;
  List<ProcedureTypes>? procedureTypes;
  bool? response;
  int? statusCode;

  ProcedureListingModel(
      {this.procedures, this.procedureTypes, this.response, this.statusCode});

  ProcedureListingModel.fromJson(Map<String, dynamic> json) {
    if (json['procedures'] != null) {
      procedures = <Procedures>[];
      json['procedures'].forEach((v) {
        procedures!.add(Procedures.fromJson(v));
      });
    }
    if (json['procedure_types'] != null) {
      procedureTypes = <ProcedureTypes>[];
      json['procedure_types'].forEach((v) {
        procedureTypes!.add(ProcedureTypes.fromJson(v));
      });
    }
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.procedures != null) {
      data['procedures'] = this.procedures!.map((v) => v.toJson()).toList();
    }
    if (this.procedureTypes != null) {
      data['procedure_types'] =
          this.procedureTypes!.map((v) => v.toJson()).toList();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Procedures {
  String? id;
  List<Detail>? detail;
  String? name;
  String? description;
  ProcedureType? procedureType;
  RxBool? isActive = false.obs;
  RxBool? isSelected = false.obs;

  Procedures(
      {this.id,
      this.detail,
      this.name,
      this.description,
      this.procedureType,
      this.isSelected});

  Procedures.fromJson(Map<String, dynamic> json) {
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
        ? ProcedureType.fromJson(json['procedure_type'])
        : null;
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
  List<dynamic>? uploads;

  Events(
      {this.eventDbId,
      this.eventName,
      this.additionalInstruction,
      this.isVisible,
      this.uploads});

  Events.fromJson(Map<String, dynamic> json) {
    eventDbId = json['event_db_id'];
    eventName = json['event_name'];
    additionalInstruction = json['additional_instruction'];
    isVisible = json['is_visible'];
    if (json['uploads'] != null) {
      uploads = <Null>[];
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
      data['uploads'] = this.uploads!.map((v) => v.toJson()).toList();
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

class ProcedureTypes {
  String? id;
  String? title;
  RxBool? isActive = false.obs;
  String? description;

  ProcedureTypes({this.id, this.title, this.description});

  ProcedureTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
