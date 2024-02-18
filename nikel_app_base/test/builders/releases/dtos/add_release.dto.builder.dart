import 'package:nikel_app_base/features/releases/dtos/add_release.dto.dart';

class AddReleaseDTOBuilder {
  final double _value = 10.0;
  final String _description = 'any_description';
  final DateTime _date = DateTime.now();
  final bool _isInflow = true;

  static AddReleaseDTOBuilder init() => AddReleaseDTOBuilder();

  AddReleaseDTO build() {
    return AddReleaseDTO(
      value: _value,
      description: _description,
      date: _date,
      isInflow: _isInflow,
    );
  }
}
