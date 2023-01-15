import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_test_task/feature/weather_info/view/bloc/exported_bloc.dart';

//виджет с тектовым полем и кнопкой подтвердить
// в зависимости от наличия текста в тектовом поле пеняются цвета кнопки и текстового поля. При отсутствии текста в текстовом поле книпка перестает быть активной
class FormWidget extends StatefulWidget {
  final RequestWeatherState state;
  const FormWidget({super.key, required this.state});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final Color primaryColor = Colors.black;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cityNameController = TextEditingController();

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        key: _formKey,
        child: TextFormField(
          enabled: (widget.state is RequestWeatherLoadingState) ? false : true,
          onChanged: ((value) => setState(() {})),
          controller: _cityNameController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_city,
                color: _cityNameController.text.isNotEmpty
                    ? primaryColor
                    : const Color(0xff747881)),
            labelText: "Город",
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF000000),
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(9.0),
              ),
            ),
            labelStyle: TextStyle(
                color: _cityNameController.text.isNotEmpty
                    ? primaryColor
                    : const Color(0xff747881)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 2.0,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(9.0),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: ((widget.state is RequestWeatherLoadingState) ||
                  !(_cityNameController.text.isNotEmpty))
              ? null
              : () {
                  BlocProvider.of<RequestWeatherBloc>(context)
                      .add(RequestWeatherLoadEvent(_cityNameController.text));
                },
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              textStyle:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          child: const Text("Подтвердить"),
        ),
      ),
    ]);
  }
}
