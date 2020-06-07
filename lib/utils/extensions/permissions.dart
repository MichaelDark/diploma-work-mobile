import 'package:permission_handler/permission_handler.dart';

const List<Permission> appPermissions = [
//    PermissionGroup.photos,
//    PermissionGroup.mediaLibrary,
  Permission.camera,
  Permission.storage,
  Permission.speech,
  Permission.location,
  Permission.microphone,
];

bool hasNotGrantedPermissions(Map<Permission, PermissionStatus> map) {
  return map.values.where((status) {
    return status != PermissionStatus.granted;
  }).isNotEmpty;
}

Future<bool> checkAppPermissions({int deepLevel = 0}) => checkPermissions(appPermissions, deepLevel: deepLevel);

Future<bool> checkPermissions(List<Permission> permissions, {int deepLevel = 0}) async {
  final initialPermissionsResult = await permissions.request();
  final isNotGranted = hasNotGrantedPermissions(initialPermissionsResult);

  if (deepLevel >= 3) {
    return false;
  } else if (isNotGranted) {
    return checkPermissions(permissions, deepLevel: ++deepLevel);
  } else {
    return true;
  }
}
