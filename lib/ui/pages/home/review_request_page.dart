import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/architecture/utils/async_stream_builder.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/models/plant_request_node.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/ui/pages/home/review_request_page_bloc.dart';
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

class ReviewRequestPage extends StatefulWidget {
  final PlantRequestNode node;

  const ReviewRequestPage(this.node);

  @override
  _ReviewRequestPageState createState() => _ReviewRequestPageState();
}

enum _ViewRequestField { Title, Description }

class _ReviewRequestPageState extends State<ReviewRequestPage> {
  ReviewRequestPageBloc _bloc = BlocProvider.getBloc<ReviewRequestPageBloc>();
  Map<_ViewRequestField, FieldData> _fields = Map.fromIterable(
    _ViewRequestField.values,
    key: (f) => f,
    value: (f) => FieldData(),
  );
  final picker = ImagePicker();
  bool _isLastActionApprove = false;

  bool _isModerator = false;
  double _latitude = 0;
  double _longitude = 0;
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _isModerator = widget.node.createUser.isModerator;
    _latitude = widget.node.latitude;
    _longitude = widget.node.longitude;
    _imageUrls = widget.node.imageUrls;
    _fields[_ViewRequestField.Description].controller.text = widget.node.description;
    _bloc.actionSubject.listen((dynamic state) async {
      if (mounted && state is SuccessState) {
        context.pushFirstPage();
      }
    });
    _bloc.userGrantSubject.listen((dynamic state) async {
      if (mounted && state is SuccessState) {
        setState(() => _isModerator = true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.actionSubject.value = null;
  }

  void _onActionTap(bool isApprove) async {
    _isLastActionApprove = isApprove;
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      final validator = Validator()
        ..add<String, String>(
          data: _fields[_ViewRequestField.Title].controller.text,
          onValidate: getEmptyValidation(context),
          onValid: (_) => _fields[_ViewRequestField.Title].errorText = null,
          onInvalid: (String errorText) => _fields[_ViewRequestField.Title].errorText = errorText,
        )
        ..add<String, String>(
          data: _fields[_ViewRequestField.Description].controller.text,
          onValidate: getEmptyValidation(context),
          onValid: (_) => _fields[_ViewRequestField.Description].errorText = null,
          onInvalid: (String errorText) => _fields[_ViewRequestField.Description].errorText = errorText,
        )
        ..add<List<String>, String>(
          data: _imageUrls,
          onValidate: (value) => value != null && value.isNotEmpty ? null : 'No images',
        );
      if (validator.validate()) {
        if (isApprove) {
          _bloc.approve(widget.node.id);
        } else {
          _bloc.decline(widget.node.id);
        }
      }
      setState(() {});
    }
  }

  void _grantModerator() {
    _bloc.grantModerator(widget.node.createUser.id);
  }

  void _onPickLocation() {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void _onRemoveImage(String filePath) async {
    if (_imageUrls.contains(filePath)) {
      setState(() => _imageUrls.remove(filePath));
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
                    context.strings.reviewPlantRequest,
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
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        context.strings.createdBy + " " + widget.node.createUser.maskedEmail,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildGrantButtonAsync(),
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
            _fields[_ViewRequestField.Title],
            maxLines: 2,
            keyboardType: TextInputType.text,
            labelText: context.strings.title,
            onDone: () => FocusScope.of(context).requestFocus(FocusNode()),
          ),
          DefaultField(
            _fields[_ViewRequestField.Description],
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            labelText: context.strings.description,
            onDone: () => FocusScope.of(context).requestFocus(FocusNode()),
          ),
        ],
      ),
    );
  }

  Widget _buildImages() {
    return Column(
      children: <Widget>[
        ..._imageUrls.map((imageUrl) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      height: 256,
                      width: 256,
                      placeholder: (context, url) => Container(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              if (_imageUrls.length > 1)
                Positioned(
                  top: 12,
                  right: 12,
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _onRemoveImage(imageUrl);
                    },
                  ),
                )
            ],
          );
        }),
      ],
    );
  }

  Widget _buildGrantButtonAsync() {
    return _isModerator
        ? Container()
        : Column(
            children: <Widget>[
              SizedBox(height: 16),
              AsyncStreamBuilder<void>(
                _bloc.userGrantSubject,
                initialBuilder: (_) => _buildGrantButton(),
                failureBuilder: (_, error) => ErrorView(
                  error,
                  onReload: () => _grantModerator,
                  margin: EdgeInsets.all(24),
                ),
              ),
            ],
          );
  }

  Widget _buildGrantButton() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ColoredButton(
        text: context.strings.makeModerator,
        onPressed: (_) => _grantModerator(),
      ),
    );
  }

  Widget _buildCreateButtonAsync() {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        AsyncStreamBuilder<void>(
          _bloc.actionSubject.stream,
          initialBuilder: (_) => _buildCreateButton(),
          failureBuilder: (_, error) => ErrorView(
            error,
            onReload: () => _onActionTap(_isLastActionApprove ?? false),
            margin: EdgeInsets.all(24),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCreateButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: ColoredButton(
              text: context.strings.approve,
              onPressed: (_) => _onActionTap(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: ColoredButton(
              text: context.strings.decline,
              onPressed: (_) => _onActionTap(false),
            ),
          ),
        ),
      ],
    );
  }
}
