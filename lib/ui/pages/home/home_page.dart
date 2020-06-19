import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/api/api_client.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/ui/views/plant_map.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/location_utils.dart';
import 'package:graduation_work_mobile/utils/storage.dart';
import 'package:stream_transform/stream_transform.dart';

const _locationDebounceDuration = Duration(milliseconds: 300);
const _tabPadding = 12.0;
const _tabIconSize = 36.0;

Stream<AsyncState<List<PlantNode>>> getPlantNodesStream(LatLng location) async* {
  yield LoadingState(true);
  try {
    yield SuccessState(await BlocProvider.getDependency<ApiClient>().getPlantNodes(location));
  } catch (e) {
    yield FailureState(e);
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng _lastUserLocation;
  List<PlantNode> _nodes;

  void _onMapCreated() async {
    getCurrentLocationStream().debounce(_locationDebounceDuration).listen(
      (LatLng userLocation) {
        if (mounted && userLocation != null) {
          _onUserLocationChanged(userLocation);
        }
      },
    );
  }

  void _onUserLocationChanged(LatLng coordinates) {
    if (coordinates != null) {
      if (coordinates != _lastUserLocation) {
        getPlantNodesStream(coordinates).listen((AsyncState<List<PlantNode>> state) {
          if (mounted && state is SuccessState<List<PlantNode>> && _nodes != state.data) {
            setState(() => _nodes = state.data);
          }
        });
      }
      setState(() {
        _lastUserLocation = coordinates;
      });
    }
  }

  void _onMarkerTap(PlantNode node) {
    context.pushPlantNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: _buildMap(),
              ),
              _buildBottomButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return PlantMap(
      selectedPosition: _lastUserLocation,
      nodes: _nodes,
      onMapCreated: _onMapCreated,
      onMarkerTap: _onMarkerTap,
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildImageTab(AssetImage('res/ic_plants.png'), () => context.pushPlantList(_lastUserLocation)),
          _buildIconTab(Icons.add_circle, () => context.pushAddRequest(_lastUserLocation)),
          if (Storage().isModerator)
            _buildIconTab(Icons.featured_play_list, () => context.pushPlantRequestList(_lastUserLocation)),
          _buildIconTab(Icons.settings, () => context.pushSettings()),
        ],
      ),
    );
  }

  Widget _buildIconTab(IconData iconData, VoidCallback onTap) {
    return IconButton(
      padding: EdgeInsets.all(_tabPadding),
      icon: Icon(iconData),
      color: AppColors.of(context).green,
      iconSize: _tabIconSize,
      onPressed: onTap,
    );
  }

  Widget _buildImageTab(ImageProvider imageProvider, VoidCallback onTap) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(_tabPadding),
        child: Image(
          image: imageProvider,
          height: _tabIconSize,
          width: _tabIconSize,
        ),
      ),
      onTap: onTap,
    );
  }
}
