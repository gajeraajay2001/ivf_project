import 'package:get/get.dart';

class DoctorSupportScreenController extends GetxController {
  List<DummyDataContent> data = [];
  @override
  void onInit() {
    getDummyData();
    super.onInit();
  }

  getDummyData() {
    data.add(DummyDataContent(
      megaTitle: "ACCOUNT",
      megaContent: [
        MegaContent(
            title: "How do I add another Clinic?",
            content:
                "You will be able to add more clinic you are operating through profile section. However, at this moment we have limited doctors to only one clinic. We will let you know when we enable the feature in future",
            isExpanded: false.obs),
        MegaContent(
            title: "Unable to update mobile number",
            content:
                "You will be able to add more clinic you are operating through profile section. However, at this moment we have limited doctors to only one clinic. We will let you know when we enable the feature in future",
            isExpanded: false.obs),
        MegaContent(
            title: "Is profile update mandatory to add patients?",
            content:
                "You will be able to add more clinic you are operating through profile section. However, at this moment we have limited doctors to only one clinic. We will let you know when we enable the feature in future",
            isExpanded: false.obs),
      ],
    ));
    data.add(DummyDataContent(
      megaTitle: "Calendar",
      megaContent: [
        MegaContent(
            title: "Can I sync my phone calendar to this app?",
            content:
                "You will be able to add more clinic you are operating through profile section. However, at this moment we have limited doctors to only one clinic. We will let you know when we enable the feature in future",
            isExpanded: false.obs),
        MegaContent(
            title: "Can I add Kanu’s events to my phone calendar?",
            content:
                "You will be able to add more clinic you are operating through profile section. However, at this moment we have limited doctors to only one clinic. We will let you know when we enable the feature in future",
            isExpanded: false.obs),
      ],
    ));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class DummyDataContent {
  String? megaTitle;
  List<MegaContent>? megaContent;

  DummyDataContent({this.megaTitle, this.megaContent});

  DummyDataContent.fromJson(Map<String, dynamic> json) {
    megaTitle = json['megaTitle'];
    if (json['megaContent'] != null) {
      megaContent = <MegaContent>[];
      json['megaContent'].forEach((v) {
        megaContent!.add(new MegaContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['megaTitle'] = this.megaTitle;
    if (this.megaContent != null) {
      data['megaContent'] = this.megaContent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MegaContent {
  String? title;
  String? content;
  RxBool? isExpanded;

  MegaContent({this.title, this.content, this.isExpanded});

  MegaContent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    isExpanded = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
