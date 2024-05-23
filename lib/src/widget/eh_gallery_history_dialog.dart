import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jhentai/src/model/gallery_url.dart';
import 'package:jhentai/src/pages/details/details_page_logic.dart';
import 'package:jhentai/src/utils/route_util.dart';
import 'package:jhentai/src/widget/eh_wheel_speed_controller.dart';

import '../config/ui_config.dart';
import '../model/child_gallery.dart';
import '../routes/routes.dart';

class EHGalleryHistoryDialog extends StatelessWidget {
  final String currentGalleryTitle;
  final GalleryUrl? parentUrl;
  final List<ChildGallery>? childrenGallerys;

  const EHGalleryHistoryDialog({
    super.key,
    required this.currentGalleryTitle,
    this.parentUrl,
    this.childrenGallerys,
  });

  @override
  Widget build(BuildContext context) {
    return EHWheelSpeedController(
      controller: null,
      child: SimpleDialog(
        title: Center(child: Text('history'.tr)),
        contentPadding: const EdgeInsets.only(top: 18, left: 12, right: 12, bottom: 12),
        children: [
          ...?childrenGallerys?.reversed.map(
            (e) => ListTile(
              dense: true,
              title: Text(
                e.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: UIConfig.galleryHistoryTitleSize),
              ),
              trailing: Text(e.updateTime, style: const TextStyle(fontSize: UIConfig.galleryHistoryDialogTrailingTextSize)),
              onTap: () {
                backRoute();
                toRoute(
                  Routes.details,
                  arguments: DetailsPageArgument(galleryUrl: e.galleryUrl),
                  offAllBefore: false,
                  preventDuplicates: false,
                );
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              currentGalleryTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: UIConfig.galleryHistoryTitleSize),
            ),
            trailing: Text('current'.tr, style: const TextStyle(fontSize: UIConfig.galleryHistoryDialogTrailingTextSize)),
            selected: true,
            selectedTileColor: UIConfig.galleryHistoryDialogTileColor(context),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
          if (parentUrl != null)
            ListTile(
              dense: true,
              title: Text('parentGallery'.tr, style: const TextStyle(fontSize: UIConfig.galleryHistoryTitleSize)),
              trailing: const Icon(Icons.exit_to_app, size: UIConfig.galleryHistoryDialogSubtitleIconSize),
              onTap: () {
                backRoute();
                toRoute(
                  Routes.details,
                  arguments: DetailsPageArgument(galleryUrl: parentUrl!),
                  offAllBefore: false,
                  preventDuplicates: false,
                );
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
        ],
      ),
    );
  }
}
