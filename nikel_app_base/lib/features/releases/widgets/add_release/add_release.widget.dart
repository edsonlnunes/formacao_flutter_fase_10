import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../shared/entities/release.entity.dart';
import '../../../../shared/views/widgets/custom_input/custom_input.widget.dart';
import '../../../../shared/views/widgets/error.modal.dart';
import '../../../../themes/app_colors.dart';
import '../../../../utils/decimal_input_formatter.dart';
import 'add_release.store.dart';

class AddRelease extends StatefulWidget {
  final double walletBalance;
  final void Function(Release) addReleaseInList;

  const AddRelease({
    super.key,
    required this.walletBalance,
    required this.addReleaseInList,
  });

  @override
  State<AddRelease> createState() => _AddReleaseState();
}

class _AddReleaseState extends State<AddRelease> {
  late TextEditingController valueController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  final _formKey = GlobalKey<FormState>();
  final store = AddReleaseStore(GetIt.I());

  @override
  void initState() {
    super.initState();
    valueController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    valueController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      dateController.text =
          DateFormat('dd-MM-yyyy').format(picked).replaceAll('-', '/');
    }
  }

  bool checkValueInWallet() {
    final value = double.parse(valueController.text);

    return value > widget.walletBalance && !store.isInflow;
  }

  Future<void> _doAddRelease() async {
    _formKey.currentState?.validate();

    final value = valueController.text;
    final description = descriptionController.text;
    final date = dateController.text;

    if (value.isNotEmpty &&
        description.isNotEmpty &&
        date.isNotEmpty &&
        !checkValueInWallet()) {
      final result = await store.addRelease(
        value: double.parse(value),
        description: description,
        date: DateFormat('dd-MM-yyyy').parse(
          date.replaceAll('/', '-'),
        ),
      );

      if (result != null) {
        widget.addReleaseInList(result);

        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Adicionar lançamento',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomInput(
                controller: valueController,
                hintText: 'Digite o valor',
                label: 'Valor',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalInputFormatter()],
                validator: (_) {
                  if (valueController.text == '0.00') {
                    return 'Digite um valor válido';
                  } else if (checkValueInWallet()) {
                    return 'Não há todo valor para saída';
                  } else if (valueController.text.isEmpty) {
                    return 'Preencha este campo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomInput(
                controller: descriptionController,
                hintText: 'Digite a descrição',
                label: 'Descrição',
              ),
              const SizedBox(height: 12),
              CustomInput(
                controller: dateController,
                hintText: 'Escolha a data',
                label: 'Data',
                onTap: () => _selectDate(context),
                readOnly: true,
              ),
              Observer(builder: (_) {
                if (store.failure != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ErrorModal.show(
                      context: context,
                      message: store.failure!,
                      onTap: () => store.clearFailure(),
                    );
                  });
                }

                return Row(
                  children: [
                    Checkbox(
                      value: store.isInflow,
                      onChanged: (_) => store.setisInflow(),
                    ),
                    const Text('Entrada'),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: !store.isInflow,
                      onChanged: (_) => store.setisInflow(),
                    ),
                    const Text('Saída'),
                  ],
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        appColors.secondaryColor,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async => _doAddRelease(),
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
