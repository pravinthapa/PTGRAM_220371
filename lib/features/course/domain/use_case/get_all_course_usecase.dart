import 'package:dartz/dartz.dart';
import 'package:prabin/app/usecase/usecase.dart';
import 'package:prabin/core/error/failure.dart';
import 'package:prabin/features/course/domain/entity/course_entity.dart';
import 'package:prabin/features/course/domain/repository/course_repository.dart';

class GetAllCourseUsecase implements UsecaseWithoutParams<List<CourseEntity>> {
  final ICourseRepository _courseRepository;

  GetAllCourseUsecase({required ICourseRepository courseRepository})
      : _courseRepository = courseRepository;

  @override
  Future<Either<Failure, List<CourseEntity>>> call() {
    return _courseRepository.getCourses();
  }
}
