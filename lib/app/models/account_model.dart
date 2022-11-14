class AccountModel {
  String? token;
  UserDetail? userDetail;
  bool? response;
  int? statusCode;

  AccountModel({this.token, this.userDetail, this.response, this.statusCode});

  AccountModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class UserDetail {
  String? id;
  String? email;
  String? userId;
  String? name;
  bool? isActive;
  bool? isPatient;
  bool? isDoctor;
  bool? isAgent;
  bool? isProfileComplete;

  UserDetail(
      {this.id,
      this.email,
      this.userId,
      this.name,
      this.isActive,
      this.isPatient,
      this.isDoctor,
      this.isAgent,
      this.isProfileComplete});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userId = json['user_id'];
    name = json['name'];
    isActive = json['is_active'];
    isPatient = json['is_patient'];
    isDoctor = json['is_doctor'];
    isAgent = json['is_agent'];
    isProfileComplete = json['is_profile_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['is_patient'] = this.isPatient;
    data['is_doctor'] = this.isDoctor;
    data['is_agent'] = this.isAgent;
    data['is_profile_complete'] = this.isProfileComplete;
    return data;
  }
}
