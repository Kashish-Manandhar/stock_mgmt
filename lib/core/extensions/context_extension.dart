import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

extension XContext on BuildContext {
  Future<void> showPermissionAlertDialog(String permissionText) => showDialog(
      context: this,
      builder: (c) {
        return AlertDialog(
          content: Column(
            children: [
              Text(permissionText),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await openAppSettings();
                    },
                    child: Text('Ok'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      c.maybePop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
