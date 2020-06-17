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
import 'package:graduation_work_mobile/utils/extensions/context.dart';

Stream<AsyncState<List<PlantNode>>> getPlantNodesStream(LatLng location) async* {
  yield LoadingState(true);
  try {
    yield SuccessState(await BlocProvider.getDependency<ApiClient>().getPlantNodes(location));
  } catch (e) {
    yield FailureState(e);
  }
}

class PlantListPage extends StatefulWidget {
  final LatLng location;

  const PlantListPage([this.location]);

  @override
  _PlantListPageState createState() => _PlantListPageState();
}

class _PlantListPageState extends State<PlantListPage> {
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
                    context.strings.plantsNearby,
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
                child: AsyncStreamBuilder<List<PlantNode>>(
                  getPlantNodesStream(widget.location),
                  onReload: () => setState(() {}),
                  successBuilder: (context, nodes) {
                    return ListView.builder(
                      padding: EdgeInsets.all(4),
                      itemCount: nodes.length,
                      itemBuilder: (context, index) {
                        return _buildPlantNode(nodes[index]);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlantNode(PlantNode node) {
    return GestureDetector(
      onTap: () => context.pushPlantNode(node),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: node.imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          if (node.isArea)
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: node.childNodes.first.imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            node.title,
                            maxLines: 3,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              Icon(
                                node.isArea ? Icons.filter_9_plus : Icons.filter_1,
                                size: 16,
                                color: Colors.lightGreen,
                              ),
                              SizedBox(width: 4),
                              Text(
                                node.isArea ? context.strings.plantArea : context.strings.singlePlant,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            node.description,
                            maxLines: 6,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${node.latitude.toStringAsFixed(4)}, ${node.longitude.toStringAsFixed(4)}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8).copyWith(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    context.strings.tapToGetInfo,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
