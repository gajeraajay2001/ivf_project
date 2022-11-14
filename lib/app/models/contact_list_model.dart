class ContactListModel {
  List<UsersContactData>? users = [];
  bool? response;
  int? statusCode;

  ContactListModel({this.users, this.response, this.statusCode});

  ContactListModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      json['users'].forEach((v) {
        users!.add(UsersContactData.fromJson(v));
      });
    }
    response = json['response'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['response'] = this.response;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class UsersContactData {
  String? id;
  String? email;
  String? userId;
  String? name;
  bool? isActive;
  bool? isPatient;
  bool? isDoctor;
  bool? isAgent;
  String? mobileNo;
  bool? isProfileComplete;

  UsersContactData(
      {this.id,
      this.email,
      this.userId,
      this.name,
      this.isActive,
      this.isPatient,
      this.isDoctor,
      this.isAgent,
      this.mobileNo,
      this.isProfileComplete});

  UsersContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userId = json['user_id'];
    name = json['name'];
    isActive = json['is_active'];
    isPatient = json['is_patient'];
    isDoctor = json['is_doctor'];
    isAgent = json['is_agent'];
    mobileNo = json['mobile_no'];
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
    data['mobile_no'] = this.mobileNo;
    data['is_profile_complete'] = this.isProfileComplete;
    return data;
  }
}
