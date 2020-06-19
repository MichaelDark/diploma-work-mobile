import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/architecture/utils/async_stream_builder.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/ui/views/plant_map.dart';
import 'package:graduation_work_mobile/ui/views/widget_visibility.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';

Stream<AsyncState<PlantNode>> getPlantRequestNodesStream(int id, bool isArea) async* {
  yield LoadingState(true);
  try {
    yield SuccessState(await BlocProvider.getDependency<ApiClient>().getPlantNode(id, isArea));
  } catch (e) {
    yield FailureState(e);
  }
}

class NodeInfoPage extends StatefulWidget {
  final int id;
  final bool isArea;

  const NodeInfoPage(this.id, this.isArea);

  NodeInfoPage.fromNode(PlantNode node) : this(node.id, node.isArea);

  @override
  _NodeInfoPageState createState() => _NodeInfoPageState();
}

class _NodeInfoPageState extends State<NodeInfoPage> {
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
                    widget.isArea ? context.strings.plantArea : context.strings.singlePlant,
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
                child: AsyncStreamBuilder<PlantNode>(
                  getPlantRequestNodesStream(widget.id, widget.isArea),
                  onReload: () => setState(() {}),
                  successBuilder: (context, node) {
                    return PlantNodeView(node);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlantNodeView extends StatefulWidget {
  final PlantNode node;

  const PlantNodeView(this.node);

  @override
  _PlantNodeViewState createState() => _PlantNodeViewState();
}

class _PlantNodeViewState extends State<PlantNodeView> {
  PlantNode get _node => widget.node;

  List<String> get _images {
    return [
      ..._node.imageUrls,
      ..._node?.childNodes?.fold(
            <String>[],
            (List<String> list, PlantNode node) => [...list, ...node.imageUrls],
          )?.toList() ??
          [],
    ];
  }

  List<PlantNode> get _specimens => [_node, if (_node.childNodes != null) ..._node.childNodes].toList();

  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            _buildImages(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${context.strings.createdBy} ${_node.createUser.maskedEmail}',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ), //created by
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${context.strings.approvedBy} ${_node.approveUser.maskedEmail}',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ), //approved by
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      '${_node.title}',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ), //title
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '${_node.description}',
                      maxLines: 16,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ), //title
                  if (_node.isArea)
                    SizedBox(height: 16),
                  if (_node.isArea)
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '${context.strings.specimen}:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ), //t
                  if (_node.isArea) // itle
                    ..._specimens.map((PlantNode specimen) => _buildSpecimen(specimen)).toList(),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PlantMap(
                      selectedPosition: LatLng(_node.latitude, _node.longitude),
                      nodes: [_node],
                      onMarkerTap: (_) {},
                      isMovable: false,
                      showLocationButton: false,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImages() {
    return Row(
      children: <Widget>[
        WidgetVisibility(
          visibility: _currentImageIndex > 0 ? WidgetVisibilityFlag.visible : WidgetVisibilityFlag.invisible,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (_currentImageIndex > 0) {
                setState(() => _currentImageIndex--);
              }
            },
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: _images[_currentImageIndex],
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              height: 256,
              width: 256,
              placeholder: (context, url) => Container(
                padding: EdgeInsets.all(8.0),
                height: 256,
                width: 256,
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        WidgetVisibility(
          visibility:
              _currentImageIndex < _images.length - 1 ? WidgetVisibilityFlag.visible : WidgetVisibilityFlag.invisible,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              if (_currentImageIndex < _images.length - 1) {
                setState(() => _currentImageIndex++);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecimen(PlantNode specimen) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => context.pushSpecimen(specimen),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightGreen.withOpacity(0.6), width: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: specimen.imageUrl,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    height: 64,
                    width: 64,
                    placeholder: (context, url) => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${specimen.title}',
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${specimen.latitude.toStringAsFixed(4)}, ${specimen.longitude.toStringAsFixed(4)}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
