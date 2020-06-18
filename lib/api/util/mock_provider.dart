import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_work_mobile/models/plant_node.dart';
import 'package:graduation_work_mobile/models/plant_request_node.dart';
import 'package:graduation_work_mobile/models/user_info.dart';

String get defaultPassword => '12345678';

LatLng get defaultLocation => LatLng(50.015340, 36.228179);

Map<String, UserInfo> users = {
  'moderator@mail.com': _mockModerator,
  'user@mail.com': _mockUser,
};

const UserInfo _mockModerator = UserInfo(id: 1, maskedEmail: 'mod***@m**.com', isModerator: true);

const UserInfo _mockUser = UserInfo(id: 2, maskedEmail: 'u***@u**.com', isModerator: false);

double _getRandomLocation(double value) => value + Random().nextDouble() / 10 * (Random().nextBool() ? 1 : -1);

List<PlantNode> getNodes(LatLng location) {
  return [
    PlantNode(
      id: 1,
      title: 'Norway Maple',
      description:
          'The leaves are opposite, 5-15 cm long and almost as broad, with 5-7 lobes each with 2-3 long, narrow teeth. They are bright, shining-green on both surfaces and hairless except in the angles of the veins below, and have leaf-stalks, often reddish, 5-20 cm long.',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
      createUser: _mockUser,
      approveUser: _mockModerator,
    ),
    PlantNode(
      id: 2,
      title: 'Buddleia',
      description:
          'The leaves are opposite, 10-25 cm long, and on very short stalks. They are dark green above and white hairy below with a finely toothed margin.',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
      createUser: _mockUser,
      approveUser: _mockModerator,
      childNodes: [
        PlantNode(
          id: 3,
          title: 'Sycamore',
          description:
              'The leaves are opposite, 7-16 cm long, with 5 coarsely-toothed lobes. They are green and hairless above, paler and hairy only on the veins below. The leaf-stalks, 10-20 cm long, are often red.',
          latitude: _getRandomLocation(location.latitude),
          longitude: _getRandomLocation(location.longitude),
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
          createUser: _mockUser,
          approveUser: _mockModerator,
        ),
      ],
    ),
    PlantNode(
      id: 4,
      title: 'Sessile Oak',
      description:
          'The alternate leaves, 5-12 cm long, have 5-6 various sized lobes on either side, and no ears at the base which narrows gradually into a leaf stalk 10-25 mm long. The leaves have persistent hairs at the base of the mid-rib beneath.',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
      createUser: _mockUser,
      approveUser: _mockModerator,
    ),
    PlantNode(
      id: 5,
      title: 'Spurge-laurel',
      description:
          'The glossy, hairless, leathery leaves are narrowly oval, about 5-12 cm long and clustered near the top of the stems. They do not smell of almonds when crushed like Cherry Laurel leaves do.',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
      createUser: _mockUser,
      approveUser: _mockModerator,
      childNodes: [
        PlantNode(
          id: 6,
          title: 'Small-leaved Lime',
          description:
              'The alternate leaves are heart-shaped, tapering abruptly to a fine tip and are 3-6 cm long. They are dark green, shiny and hairless above and with tufts of rusty hairs only at the junction of the veins below. The margins have sharp teeth and the leaf-stalks are 15-30 mm long.',
          latitude: _getRandomLocation(location.latitude),
          longitude: _getRandomLocation(location.longitude),
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
          createUser: _mockUser,
          approveUser: _mockModerator,
        ),
        PlantNode(
          id: 7,
          title: 'Traveller\'s-joy',
          description:
              'The opposite, pinnate leaves are made of 3-5 well-separated, sparsely toothed leaflets, each 3-10 cm long and almost hairless. The stalks of the leaf and of each leaflet are 2-3 cm long. They are sensitive and can twine round the branches of other trees.',
          latitude: _getRandomLocation(location.latitude),
          longitude: _getRandomLocation(location.longitude),
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
          createUser: _mockUser,
          approveUser: _mockModerator,
        ),
        PlantNode(
          id: 6,
          title: 'Wild Cherry',
          description:
              'The elliptical leaves are alternate, 6-15 cm long, with a saw-edged margin. They are light green and hairless above but have persistent appressed hairs beneath. The leaf stalks are up to 5 cm long with 2 large glands at the leaf end.',
          latitude: _getRandomLocation(location.latitude),
          longitude: _getRandomLocation(location.longitude),
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
          createUser: _mockUser,
          approveUser: _mockModerator,
        ),
        PlantNode(
          id: 9,
          title: 'Wild Privet',
          description:
              'The opposite leaves are long, oval, pointed and leathery. They are hairless, shiny above and paler below and have very short stalks.',
          latitude: _getRandomLocation(location.latitude),
          longitude: _getRandomLocation(location.longitude),
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
          createUser: _mockUser,
          approveUser: _mockModerator,
        ),
        PlantNode(
          id: 10,
          title: 'White Poplar',
          description:
              'The leaves are alternate, leathery, 3-9 cm long, with 3-5 lobes and flattened leaf-stalks 5-6 cm long. They are dark-green above but densely white-hairy below. Those on short shoots have shallower lobes than those on long shoots which can be almost palmate like a maple or sycamore.',
          latitude: _getRandomLocation(location.latitude),
          longitude: _getRandomLocation(location.longitude),
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
          createUser: _mockUser,
          approveUser: _mockModerator,
        ),
      ],
    )
  ];
}

List<PlantRequestNode> getRequestNodes(LatLng location) {
  return [
    PlantRequestNode(
      id: 1,
      description: 'Please help me detect what is this',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
    ),
    PlantRequestNode(
      id: 2,
      description: 'What is it',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
    ),
    PlantRequestNode(
      id: 3,
      description: 'I think, it is a tree',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
    ),
    PlantRequestNode(
      id: 4,
      description: 'WTF?! What is it?!',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1557258847-chinese-evergreen-houseplant-1557258690.jpg',
    ),
    PlantRequestNode(
      id: 5,
      description: 'Fagus sylvatica specimen',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRuJDxU_mMOPlyGwDuI2BHfUizdLbynN8NLO8VNY6DI2st6OPo6&usqp=CAU',
    ),
    PlantRequestNode(
      id: 6,
      description: 'Please, add this Hippophae rhamnoides',
      latitude: _getRandomLocation(location.latitude),
      longitude: _getRandomLocation(location.longitude),
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ1KFRlpC6k3s8QSrRJlDj8lmiNpKMA5XObgMgWBXgODNJwpQDh&usqp=CAU',
    ),
  ];
}
