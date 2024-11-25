import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_management/core/helpers/image_picker_helper.dart';

class ImageHolder extends StatelessWidget {
  const ImageHolder({
    super.key,
    this.imageFile,
    this.imageUrl,
    this.isEditable = false,
    this.onSelectImage,
  });

  final XFile? imageFile;
  final String? imageUrl;
  final bool isEditable;
  final Function(XFile?)? onSelectImage;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: imagePlaceHolder(imageFile, imageUrl),
      ),
      if (isEditable)
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            child: const Icon(Icons.edit),
            onTap: () async {
              // print('hiu');
              final result = await showModalBottomSheet<XFile?>(
                  context: context,
                  builder: (c) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Pick Image From'),
                        ListTile(
                          title: const Text('From Gallery'),
                          onTap: () async {
                            final result =
                                await ImagePickerHelper.pickImageFromGallery(
                                    context);
                            if (c.mounted) {
                              c.maybePop(result);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: const Text('From Camera'),
                          onTap: () async {
                            final result =
                                await ImagePickerHelper.pickImageFromCamera(
                                    context);
                            if (c.mounted) {
                              c.maybePop(result);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  });
              onSelectImage?.call(result);
            },
          ),
        ),
    ]);
  }

  Widget imagePlaceHolder(XFile? imageFile, String? imageUrl) {
    if (imageFile != null) {
      return Image.file(File(imageFile.path));
    } else {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        return Image.network(imageUrl);
      } else {
        return const SizedBox();
      }
    }
  }
}
