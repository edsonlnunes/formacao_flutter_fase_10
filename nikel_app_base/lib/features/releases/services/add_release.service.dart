import 'package:dio/dio.dart';

import '../../../shared/entities/release.entity.dart';
import '../../../utils/app.constants.dart';
import '../dtos/add_release.dto.dart';

class AddReleaseService {
  final Dio dio;

  AddReleaseService(this.dio);

  Future<Release> call(AddReleaseDTO dto) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/releases',
      data: dto.toMap(),
      options: AppConstants.dioOptions,
    );

    return Release.fromMap(response.data);
  }
}
