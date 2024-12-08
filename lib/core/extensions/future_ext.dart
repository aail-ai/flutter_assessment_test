import 'package:flutter_assessment_test/core/types/resource.dart';

extension DataToResouceExt<T extends dynamic> on Future<T> {
  Future<Resource<T>> get asResource async => Resource.success(await this);
}
