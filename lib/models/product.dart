class Product {
  List<Course> course;
  Meta meta;

  Product({this.course, this.meta});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      course = new List<Course>();
      json['data'].forEach((v) {
        course.add(new Course.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> course = new Map<String, dynamic>();
    if (this.course != null) {
      course['course'] = this.course.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      course['meta'] = this.meta.toJson();
    }
    return course;
  }
}

class Course {
  int id;
  String title;
  String detail;
  String date;
  int view;
  String picture;

  Course({this.id, this.title, this.detail, this.date, this.view, this.picture});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    date = json['date'];
    view = json['view'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> course = new Map<String, dynamic>();
    course['id'] = this.id;
    course['title'] = this.title;
    course['detail'] = this.detail;
    course['date'] = this.date;
    course['view'] = this.view;
    course['picture'] = this.picture;
    return course;
  }
}

class Meta {
  String status;
  int statusCode;

  Meta({this.status, this.statusCode});

  Meta.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> course = new Map<String, dynamic>();
    course['status'] = this.status;
    course['status_code'] = this.statusCode;
    return course;
  }
}
