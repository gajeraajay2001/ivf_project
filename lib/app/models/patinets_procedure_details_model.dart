import 'package:get/get.dart';
import 'package:ivf_project/app/constants/api_constant.dart';
import 'package:ivf_project/app/models/procedures_details_model.dart';

class PatientProcedureDetailModel {
  String? patientProcedureDbId;
  PatientProcedure? patientProcedure;
  bool? response;
  int? statusCode;

  PatientProcedureDetailModel(
      {this.patientProcedureDbId,
      this.patientProcedure,
      this.response,
      this.statusCode});

  PatientProcedureDetailModel.fromJson(Map<String, dynamic> json) {
    patientProcedureDbId = json['patient_procedure_db_id'];
    patientProcedure = json['patient_procedure'] != null
        ? new PatientProcedure.fromJson(json['patient_procedure'])
        : null;
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_procedure_db_id'] = this.patientProcedureDbId;
    if (this.patientProcedure != null) {
      data['patient_procedure'] = this.patientProcedure!.toJson();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class PatientProcedure {
  String? age;
  List<Detail>? detail = [];
  String? id;
  Procedure? procedure;
  String? patientName;

  PatientProcedure(
      {this.age, this.detail, this.id, this.procedure, this.patientName});

  PatientProcedure.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    if (json['detail'] != null) {
      json['detail'].forEach((v) {
        detail!.add(Detail.fromJson(v));
      });
    }
    id = json['id'];
    procedure = json['procedure'] != null
        ? new Procedure.fromJson(json['procedure'])
        : null;
    patientName = json['patient_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    if (this.procedure != null) {
      data['procedure'] = this.procedure!.toJson();
    }
    data['patient_name'] = this.patientName;
    return data;
  }
}

// class Details {
//   int? day;
//   String? date;
//   bool? isToday;
//   List<Events>? events;
//
//   Details({this.day, this.date, this.isToday, this.events});
//
//   Details.fromJson(Map<String, dynamic> json) {
//     day = json['day'];
//     date = json['date'];
//     isToday = json['is_today'];
//     if (json['events'] != null) {
//       events = <Events>[];
//       json['events'].forEach((v) {
//         events!.add(new Events.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['day'] = this.day;
//     data['date'] = this.date;
//     data['is_today'] = this.isToday;
//     if (this.events != null) {
//       data['events'] = this.events!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Events {
//   String? eventDbId;
//   String? eventName;
//   String? additionalInstruction;
//   bool? isVisible;
//   List<String>? uploads = [];
//   RxBool? isActive;
//   RxString? image;
//
//   Events(
//       {this.eventDbId,
//       this.eventName,
//       this.additionalInstruction,
//       this.isVisible,
//       this.uploads});
//
//   Events.fromJson(Map<String, dynamic> json) {
//     eventDbId = json['event_db_id'];
//     eventName = json['event_name'];
//     additionalInstruction = json['additional_instruction'];
//     isVisible = json['is_visible'];
//     if (json['uploads'] != null) {
//       json['uploads'].forEach((v) {
//         uploads!.add(v);
//       });
//     }
//     isActive = false.obs;
//     image = getImageById(id: eventDbId!).obs;
//     if (json['uploads'] != null) {
//       json['uploads'].forEach((v) {
//         uploads!.add(v);
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['event_db_id'] = this.eventDbId;
//     data['event_name'] = this.eventName;
//     data['additional_instruction'] = this.additionalInstruction;
//     data['is_visible'] = this.isVisible;
//     if (this.uploads != null) {
//       data['uploads'] = this.uploads;
//     }
//     return data;
//   }
// }

class Procedure {
  String? name;
  String? procedureDbId;

  Procedure({this.name, this.procedureDbId});

  Procedure.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    procedureDbId = json['procedure_db_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['procedure_db_id'] = this.procedureDbId;
    return data;
  }
}
