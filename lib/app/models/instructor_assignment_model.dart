import 'assignment_model.dart';

class InstructorAssignmentModel {
  int? courseAssignmentsCount;
  int? pendingReviewsCount;
  int? passedCount;
  int? failedCount;
  List<AssignmentModel>? assignments;

  InstructorAssignmentModel(
      {this.courseAssignmentsCount,
      this.pendingReviewsCount,
      this.passedCount,
      this.failedCount,
      this.assignments});

  InstructorAssignmentModel.fromJson(Map<String, dynamic> json) {
    courseAssignmentsCount = json['course_assignments_count'];
    pendingReviewsCount = json['pending_reviews_count'];
    passedCount = json['passed_count'];
    failedCount = json['failed_count'];
    if (json['assignments'] != null) {
      assignments = <AssignmentModel>[];
      json['assignments'].forEach((v) {
        assignments!.add(AssignmentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_assignments_count'] = courseAssignmentsCount;
    data['pending_reviews_count'] = pendingReviewsCount;
    data['passed_count'] = passedCount;
    data['failed_count'] = failedCount;
    if (assignments != null) {
      data['assignments'] = assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
