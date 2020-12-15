class Detail {
  String status;
  int statusCode;
  List<Chapter> chapter;

  Detail({this.status, this.statusCode, this.chapter});

  Detail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      chapter = new List<Chapter>();
      json['data'].forEach((v) {
        chapter.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> chapter = new Map<String, dynamic>();
    chapter['status'] = this.status;
    chapter['status_code'] = this.statusCode;
    if (this.chapter != null) {
      chapter['chapter'] = this.chapter.map((v) => v.toJson()).toList();
    }
    return chapter;
  }
}

class Chapter {
  int chId;
  int courseId;
  String chTitle;
  String chDateadd;
  String chTimetotal;
  int chView;
  String chUrl;

  Chapter(
      {this.chId,
      this.courseId,
      this.chTitle,
      this.chDateadd,
      this.chTimetotal,
      this.chView,
      this.chUrl});

  Chapter.fromJson(Map<String, dynamic> json) {
    chId = json['ch_id'];
    courseId = json['course_id'];
    chTitle = json['ch_title'];
    chDateadd = json['ch_dateadd'];
    chTimetotal = json['ch_timetotal'];
    chView = json['ch_view'];
    chUrl = json['ch_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> chapter = new Map<String, dynamic>();
    chapter['ch_id'] = this.chId;
    chapter['course_id'] = this.courseId;
    chapter['ch_title'] = this.chTitle;
    chapter['ch_dateadd'] = this.chDateadd;
    chapter['ch_timetotal'] = this.chTimetotal;
    chapter['ch_view'] = this.chView;
    chapter['ch_url'] = this.chUrl;
    return chapter;
  }
}
