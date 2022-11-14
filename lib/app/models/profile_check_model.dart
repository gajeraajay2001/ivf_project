import 'package:ivf_project/app/constants/sizeConstant.dart';

class ProfileCheckModel {
  String? address;
  String? clinicName;
  String? licenseId;
  String? highestEducation;
  bool? isProfileComplete;
  int? daysSinceLastUpdate;
  bool? response;
  int? statusCode;
  String? name;
  bool? isUpdateProfileSkipped;
  String? mobileNumber;
  ProfileCheckModel({
    this.address,
    this.clinicName,
    this.licenseId,
    this.highestEducation,
    this.isProfileComplete,
    this.daysSinceLastUpdate,
    this.response,
    this.statusCode,
    this.name,
    this.mobileNumber,
  });

  ProfileCheckModel.fromJson(Map<String, dynamic> json) {
    address = json['clinic_name'];
    // address = json['address'];
    clinicName = json['clinic_name'];
    licenseId = json['license_id'];
    highestEducation = json['highest_education'];
    isProfileComplete = json['is_profile_complete'];
    daysSinceLastUpdate = json['days_since_last_update'];
    response = json['response'];
    statusCode = json['status_code'];
    name = json['name'];
    if (!isNullEmptyOrFalse(json["is_update_profile_skipped"])) {
      isUpdateProfileSkipped = json["is_update_profile_skipped"];
    }
    if (!isNullEmptyOrFalse(json["mobile_number"])) {
      mobileNumber = json["mobile_number"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['clinic_name'] = this.clinicName;
    data['license_id'] = this.licenseId;
    data['highest_education'] = this.highestEducation;
    data['is_profile_complete'] = this.isProfileComplete;
    data['days_since_last_update'] = this.daysSinceLastUpdate;
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}
