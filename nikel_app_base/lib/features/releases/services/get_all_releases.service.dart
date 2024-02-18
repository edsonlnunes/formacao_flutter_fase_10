import 'package:dio/dio.dart';

import '../../../shared/entities/release.entity.dart';
import '../../../utils/app.constants.dart';

class GetAllReleasesService {
  final Dio dio;

  GetAllReleasesService(this.dio);

  Future<List<Release>> call() async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/releases',
      options: AppConstants.dioOptions,
    );

    print(response.data);

    return List<Release>.from(response.data.map((e) => Release.fromMap(e)));
  }
}
