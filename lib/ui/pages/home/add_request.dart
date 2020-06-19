import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/architecture/utils/async_stream_builder.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/models/plant_request.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/ui/views/buttons/colored_button.dart';
import 'package:graduation_work_mobile/ui/views/error_view.dart';
import 'package:graduation_work_mobile/ui/views/inputs/default_field.dart';
import 'package:graduation_work_mobile/ui/views/inputs/standard_field.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/ui/views/plant_map.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/validator.dart';
import 'package:graduation_work_mobile/utils/validators.dart';
import 'package:image_picker/image_picker.dart';

import 'add_request_bloc.dart';

class AddRequestPage extends StatefulWidget {
  final LatLng userPosition;

  const AddRequestPage([this.userPosition]);

  @override
  _AddRequestPageState createState() => _AddRequestPageState();
}

enum _AddRequestField { Description }

class _AddRequestPageState extends State<AddRequestPage> {
  AddRequestPageBloc _bloc = BlocProvider.getBloc<AddRequestPageBloc>();
  Map<_AddRequestField, FieldData> _fields = Map.fromIterable(
    _AddRequestField.values,
    key: (f) => f,
    value: (f) => FieldData(),
  );
  final picker = ImagePicker();

  double _latitude = 0;
  double _longitude = 0;
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _latitude = widget.userPosition?.latitude ?? 0;
    _longitude = widget.userPosition?.longitude ?? 0;
    _bloc.createSubject.listen((dynamic state) async {
      if (mounted && state is SuccessState<String>) {
        context.pushFirstPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.createSubject.value = null;
  }

  void _onCreateTap() async {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      final validator = Validator()
        ..add<String, String>(
          data: _fields[_AddRequestField.Description].controller.text,
          onValidate: getEmptyValidation(context),
          onValid: (_) => _fields[_AddRequestField.Description].errorText = null,
          onInvalid: (String errorText) => _fields[_AddRequestField.Description].errorText = errorText,
        )
        ..add<List<String>, String>(
          data: _imagePaths,
          onValidate: (value) => value != null && value.isNotEmpty ? null : 'No images',
        );
      if (validator.validate()) {
        _bloc.createPlantRequest(
          PlantRequest(
            description: _fields[_AddRequestField.Description].controller.text,
            longitude: -_longitude,
            latitude: _latitude,
            images: _imagePaths.map((filePath) => File(filePath)).toList(),
          ),
        );
      }
      setState(() {});
    }
  }

  void _onPickLocation() {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void _onAddImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null && !_imagePaths.contains(pickedFile.path)) {
      setState(() => _imagePaths.insert(0, pickedFile.path));
    }
  }

  void _onRemoveImage(String filePath) async {
    if (_imagePaths.contains(filePath)) {
      setState(() => _imagePaths.remove(filePath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Text(
                    context.strings.addPlant,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.of(context).black,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: ListView(
                  children: <Widget>[
                    _buildLocation(),
                    SizedBox(height: 16),
                    _buildDescriptionField(),
                    SizedBox(height: 16),
                    _buildImages(),
                    SizedBox(height: 16),
                    _buildCreateButtonAsync(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return GestureDetector(
      onTap: _onPickLocation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              context.strings.tapOnMapToPickLocation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: PlantMap(
              selectedPosition: LatLng(_latitude, _longitude),
              nodes: [
                PlantNode(
                  latitude: _latitude,
                  longitude: _longitude,
                  id: null,
                  approveUser: null,
                  createUser: null,
                  description: null,
                  imageUrl: null,
                  title: null,
                )
              ],
              onMarkerTap: (_) {},
              isMovable: false,
              showLocationButton: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          DefaultField(
            _fields[_AddRequestField.Description],
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            labelText: context.strings.description,
            nextFocus: _fields[_AddRequestField.Description].node,
            onDone: () => FocusScope.of(context).requestFocus(FocusNode()),
          ),
        ],
      ),
    );
  }

  Widget _buildImages() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: IntrinsicWidth(
            child: ColoredButton(
              text: context.strings.addImage,
              primaryColor: Colors.blue.shade300,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
              onPressed: (_) => _onAddImage(),
            ),
          ),
        ),
        ..._imagePaths.map((filePath) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Image.file(
                      File(filePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _onRemoveImage(filePath);
                  },
                ),
              )
            ],
          );
        }),
      ],
    );
  }

  Widget _buildCreateButtonAsync() {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        AsyncStreamBuilder<void>(
          _bloc.createSubject.stream,
          initialBuilder: (_) => _buildCreateButton(),
          failureBuilder: (_, error) => ErrorView(error, onReload: _onCreateTap, margin: EdgeInsets.all(24)),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ColoredButton(
        text: context.strings.sendPlantToModerator,
        onPressed: (_) => _onCreateTap(),
      ),
    );
  }
}
