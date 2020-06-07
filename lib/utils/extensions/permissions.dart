import 'package:permission_handler/permission_handler.dart';

bool hasNotGrantedPermissions(Map<Permission, PermissionStatus> map) {
  return map.values.where((status) {
    return status != PermissionStatus.granted;
  }).isNotEmpty;
}
