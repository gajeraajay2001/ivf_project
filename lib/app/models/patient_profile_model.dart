class PatientProfileModel {
  String? aadharNo;
  String? name;
  String? msCycleStartDate;
  List<String>? uploads;
  String? mobileNumber;
  bool? isProfileComplete;
  bool? isUpdateProfileSkipped;
  int? daysSinceLastUpdate;
  bool? response;
  int? statusCode;

  PatientProfileModel(
      {this.aadharNo,
      this.name,
      this.msCycleStartDate,
      this.uploads,
      this.mobileNumber,
      this.isProfileComplete,
      this.isUpdateProfileSkipped,
      this.daysSinceLastUpdate,
      this.response,
      this.statusCode});

  PatientProfileModel.fromJson(Map<String, dynamic> json) {
    aadharNo = json['aadhar_no'];
    name = json['name'];
    msCycleStartDate = json['ms_cycle_start_date'];
    uploads = json['uploads'].cast<String>();
    mobileNumber = json['mobile_number'];
    isProfileComplete = json['is_profile_complete'];
    isUpdateProfileSkipped = json['is_update_profile_skipped'];
    daysSinceLastUpdate = json['days_since_last_update'];
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aadhar_no'] = this.aadharNo;
    data['name'] = this.name;
    data['ms_cycle_start_date'] = this.msCycleStartDate;
    data['uploads'] = this.uploads;
    data['mobile_number'] = this.mobileNumber;
    data['is_profile_complete'] = this.isProfileComplete;
    data['is_update_profile_skipped'] = this.isUpdateProfileSkipped;
    data['days_since_last_update'] = this.daysSinceLastUpdate;
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}
