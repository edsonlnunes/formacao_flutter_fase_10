import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/entities/release.entity.dart';
import '../../dtos/add_release.dto.dart';
import '../../services/add_release.service.dart';

part 'add_release.store.g.dart';

// ignore: library_private_types_in_public_api
class AddReleaseStore = _AddReleaseStoreBase with _$AddReleaseStore;

abstract class _AddReleaseStoreBase with Store {
  final AddReleaseService _addReleaseService;

  _AddReleaseStoreBase(this._addReleaseService);

  @observable
  bool isInflow = true;

  @action
  void setisInflow() => isInflow = !isInflow;

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  clearFailure() => failure = null;

  @action
  Future<Release?> addRelease({
    required double value,
    required String description,
    required DateTime date,
  }) async {
    clearFailure();
    isLoading = true;

    try {
      final tempRelease = await _addReleaseService(
        AddReleaseDTO(
          value: value,
          description: description,
          date: date,
          isInflow: isInflow,
        ),
      );

      isLoading = false;

      return tempRelease;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;

      return null;
    }
  }
}
