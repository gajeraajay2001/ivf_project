import 'package:intl/intl.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';

class PatientsListModel {
  List<Patients>? patients = [];
  bool? response;
  int? statusCode;

  PatientsListModel({this.patients, this.response, this.statusCode});

  PatientsListModel.fromJson(Map<String, dynamic> json) {
    if (json['patients'] != null) {
      json['patients'].forEach((v) {
        patients!.add(Patients.fromJson(v));
      });
    }
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.patients != null) {
      data['patients'] = this.patients!.map((v) => v.toJson()).toList();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Patients {
  Patient? patient;
  List<Events>? events = [];
  bool isYetToStart = false;

  Patients({this.patient, this.events, this.isYetToStart = false});

  Patients.fromJson(Map<String, dynamic> json) {
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    if (json['events'] != null) {
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
    if (isNullEmptyOrFalse(events)) {
      isYetToStart = true;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  int? day;
  List<EventsData>? events = [];
  String? date;
  DateTime? dateTime;
  bool isTodayAvailable = true;

  Events(
      {this.day,
      this.events,
      this.date,
      this.dateTime,
      this.isTodayAvailable = false});

  Events.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['events'] != null) {
      json['events'].forEach((v) {
        events!.add(EventsData.fromJson(v));
      });
    }
    date = json['date'];
    if (!isNullEmptyOrFalse(date)) {
      dateTime = DateFormat("dd MMMM yyyy").parse(date!);
      if (dateTime == DateTime.now()) {
        isTodayAvailable = true;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['day'] = this.day;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class EventsData {
  String? eventDbId;
  String? eventName;
  String? additionalInstruction;
  bool? isVisible;
  List<String>? uploads = [];

  EventsData(
      {this.eventDbId,
      this.eventName,
      this.additionalInstruction,
      this.isVisible,
      this.uploads});

  EventsData.fromJson(Map<String, dynamic> json) {
    eventDbId = json['event_db_id'];
    eventName = json['event_name'];
    additionalInstruction = json['additional_instruction'];
    isVisible = json['is_visible'];
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
      data['uploads'] = this.uploads!;
    }
    return data;
  }
}

class Patient {
  String? id;
  String? status;
  PatientDetail? patient;
  Procedure? procedure;
  String? patientProfile;
  String? msCycleStart;
  String? previousMsCycle;
  DateTime? msCycleStartDateTime;
  bool isProcedureStarted = true;
  Patient({
    this.id,
    this.patient,
    this.procedure,
    this.patientProfile,
    this.msCycleStart,
    this.msCycleStartDateTime,
    this.isProcedureStarted = true,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    patient = json['patient'] != null
        ? PatientDetail.fromJson(json['patient'])
        : null;
    procedure = json['procedure'] != null
        ? Procedure.fromJson(json['procedure'])
        : null;
    patientProfile = json['patient_profile'];
    msCycleStart = json['ms_cycle_start'];
    if (!isNullEmptyOrFalse(json["previous_ms_cycle"])) {
      previousMsCycle = json["previous_ms_cycle"];
    }
    if (!isNullEmptyOrFalse(msCycleStart)) {
      msCycleStartDateTime = DateFormat("dd MMMM yyyy").parse(msCycleStart!);
      if (msCycleStartDateTime!.isAfter(DateTime.now())) {
        isProcedureStarted = false;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.procedure != null) {
      data['procedure'] = this.procedure!.toJson();
    }
    data['patient_profile'] = this.patientProfile;
    data['ms_cycle_start'] = this.msCycleStart;
    return data;
  }
}

class PatientDetail {
  String? userDbId;
  String? name;

  PatientDetail({this.userDbId, this.name});

  PatientDetail.fromJson(Map<String, dynamic> json) {
    userDbId = json['user_db_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_db_id'] = this.userDbId;
    data['name'] = this.name;
    return data;
  }
}

class Procedure {
  String? name;
  String? procedureDbId;

  Procedure({this.name, this.procedureDbId});

  Procedure.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    procedureDbId = json['procedure_db_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['procedure_db_id'] = this.procedureDbId;
    return data;
  }
}
