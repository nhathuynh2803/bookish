import 'dart:collection';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jhentai/src/consts/color_consts.dart';
import 'package:jhentai/src/model/gallery.dart';
import 'package:jhentai/src/model/gallery_detail.dart';
import 'package:jhentai/src/model/gallery_image.dart';
import 'package:jhentai/src/routes/routes.dart';
import 'package:jhentai/src/service/tag_translation_service.dart';
import 'package:jhentai/src/setting/user_setting.dart';
import 'package:jhentai/src/pages/details/widget/eh_comment.dart';
import 'package:jhentai/src/widget/eh_image.dart';
import 'package:jhentai/src/widget/eh_tag.dart';
import 'package:jhentai/src/widget/icon_text_button.dart';
import 'package:jhentai/src/widget/loading_state_indicator.dart';

import '../../database/database.dart';
import '../../model/gallery_thumbnail.dart';
import '../../service/download_service.dart';
import '../../service/storage_service.dart';
import '../../utils/date_util.dart';
import '../../widget/gallery_category_tag.dart';
import 'details_page_logic.dart';
import 'details_page_state.dart';

class DetailsPage extends StatelessWidget {
  final DetailsPageLogic detailsPageLogic = Get.put(
    DetailsPageLogic(),
    tag: DetailsPageLogic.currentStackDepth.toString(),
  );
  final DetailsPageState detailsPageState = DetailsPageLogic.currentDetailsPageLogic.state;
  final DownloadService downloadService = Get.find();
  final TagTranslationService tagTranslationService = Get.find();
  final StorageService storageService = Get.find();

  DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsPageLogic>(
        tag: DetailsPageLogic.currentStackDepth.toString(),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: Text(detailsPageState.gallery?.title ?? ''),
              titleTextStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: Builder(
              builder: (context) {
                Gallery? gallery = detailsPageState.gallery;

                if (gallery == null) {
                  return const Align(
                    child: CupertinoActivityIndicator(radius: 20),
                    alignment: Alignment(0, -0.25),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 0.2,
                        color: Get.theme.appBarTheme.foregroundColor!,
                      ),
                    ),
                  ),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      CupertinoSliverRefreshControl(onRefresh: detailsPageLogic.handleRefresh),
                      _buildHeader(gallery, context),
                      _buildDetails(gallery, detailsPageState.galleryDetails),
                      _buildActions(gallery, detailsPageState.galleryDetails, context),
                      if (detailsPageState.galleryDetails?.fullTags.isNotEmpty ?? false)
                        _buildTags(detailsPageState.galleryDetails!.fullTags),
                      _buildLoadingDetailsIndicator(),
                      if (detailsPageState.galleryDetails != null)
                        _buildCommentsIndicator(detailsPageState.galleryDetails!),
                      if (detailsPageState.galleryDetails?.comments.isNotEmpty ?? false)
                        _buildComments(detailsPageState.galleryDetails!),
                      if (detailsPageState.galleryDetails != null) _buildThumbnails(detailsPageState.galleryDetails!),
                      if (detailsPageState.galleryDetails != null) _buildLoadingThumbnailIndicator(),
                    ],
                  ).paddingOnly(top: 10, left: 15, right: 15),
                );
              },
            ),
          );
        });
  }

  Widget _buildHeader(Gallery gallery, BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: EHImage(
                    containerHeight: 200,
                    containerWidth: 140,
                    galleryImage: gallery.cover,
                    adaptive: true,
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  Get.toNamed(Routes.singleImagePage, arguments: gallery.cover);
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            gallery.title,
                            minLines: 1,
                            maxLines: 7,
                            style: const TextStyle(fontSize: 16, height: 1.2),
                          ),
                          SelectableText(
                            gallery.uploader,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                  ],
                ).paddingOnly(left: 6),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(Gallery gallery, GalleryDetail? galleryDetails) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 18),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        galleryDetails?.realRating.toString() ?? '    ',
                        style: const TextStyle(fontSize: 18),
                      ),
                      RatingBar.builder(
                        unratedColor: Colors.grey.shade300,
                        initialRating: galleryDetails == null ? 0 : gallery.rating,
                        itemCount: 5,
                        allowHalfRating: true,
                        itemSize: 18,
                        ignoreGestures: true,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: gallery.hasRated ? Get.theme.primaryColor : Colors.amber.shade800,
                        ),
                        onRatingUpdate: (rating) {},
                      ).marginOnly(left: 4),
                      Row(
                        children: [
                          Text(
                            galleryDetails?.ratingCount.toString() ?? '',
                            style: const TextStyle(fontSize: 8, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  GalleryCategoryTag(
                    category: gallery.category,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      Text(
                        gallery.language ?? 'Japanese',
                        style: const TextStyle(fontSize: 13),
                      ).marginOnly(left: 2),
                    ],
                  ),
                  Text(
                    galleryDetails?.size ?? '',
                    style: const TextStyle(fontSize: 13),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.collections,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Text(
                        gallery.pageCount.toString(),
                        style: const TextStyle(fontSize: 13),
                      ).marginOnly(left: 2),
                    ],
                  ),
                ],
              ).marginOnly(top: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 12,
                        color: Colors.red,
                      ),
                      Text(
                        galleryDetails?.favoriteCount.toString() ?? '0',
                        style: const TextStyle(fontSize: 13),
                      ).marginOnly(left: 2),
                    ],
                  ),
                  Text(
                    DateUtil.transform2LocalTimeString(gallery.publishTime),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(Gallery gallery, GalleryDetail? galleryDetails, BuildContext context) {
    int readIndexRecord = storageService.read('readIndexRecord::${detailsPageState.gallery!.gid}') ?? 0;

    return SliverPadding(
      padding: const EdgeInsets.only(top: 24),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemExtent: (context.width - 30) / 4.7,
            children: [
              IconTextButton(
                iconData: Icons.visibility,
                iconSize: 28,
                onPressed: () => detailsPageLogic.goToReadPage(),
                text: Text(
                  'read'.tr + (readIndexRecord > 0 ? ' P' + (readIndexRecord + 1).toString() : ''),
                  style: TextStyle(fontSize: 12, color: Get.theme.appBarTheme.titleTextStyle?.color),
                ),
              ),
              IconTextButton(
                iconData: Icons.download,
                iconSize: 30,
                onPressed: () => detailsPageLogic.handleTapDownload(),
                text: Obx(() {
                  return Text(
                    downloadService.gid2downloadProgress[gallery.gid] == null
                        ? 'download'.tr
                        : downloadService.gid2downloadProgress[gallery.gid]!.value.downloadStatus ==
                                DownloadStatus.paused
                            ? 'resume'.tr
                            : downloadService.gid2downloadProgress[gallery.gid]!.value.downloadStatus ==
                                    DownloadStatus.downloaded
                                ? 'finished'.tr
                                : 'pause'.tr,
                    style: TextStyle(fontSize: 12, color: Get.theme.appBarTheme.titleTextStyle?.color),
                  );
                }),
              ),
              LoadingStateIndicator(
                width: (context.width - 30) / 6,
                loadingState: detailsPageState.addFavoriteState,
                idleWidget: IconTextButton(
                  iconData: gallery.isFavorite && detailsPageState.galleryDetails != null
                      ? Icons.favorite
                      : Icons.favorite_border,
                  iconSize: 26,
                  iconColor: gallery.isFavorite && detailsPageState.galleryDetails != null
                      ? ColorConsts.favoriteTagColor[gallery.favoriteTagIndex!]
                      : null,
                  text: Text(
                    gallery.isFavorite ? gallery.favoriteTagName! : 'favorite'.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.appBarTheme.titleTextStyle?.color,
                    ),
                  ),
                  onPressed: detailsPageState.galleryDetails == null
                      ? null
                      : UserSetting.hasLoggedIn()
                          ? detailsPageLogic.handleTapFavorite
                          : detailsPageLogic.showLoginSnack,
                ),
                errorWidgetSameWithIdle: true,
              ),
              IconTextButton(
                iconData: gallery.hasRated && detailsPageState.galleryDetails != null ? Icons.star : Icons.star_border,
                iconColor: gallery.hasRated && detailsPageState.galleryDetails != null ? Colors.red.shade700 : null,
                iconSize: 28,
                text: Text(
                  gallery.hasRated ? gallery.rating.toString() : 'rating'.tr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.appBarTheme.titleTextStyle?.color,
                  ),
                ),
                onPressed: detailsPageState.galleryDetails == null
                    ? null
                    : UserSetting.hasLoggedIn()
                        ? detailsPageLogic.handleTapRating
                        : detailsPageLogic.showLoginSnack,
              ),
              IconTextButton(
                iconData: FontAwesomeIcons.magnet,
                iconSize: 24,
                text: Text(
                  '${'torrent'.tr}(${detailsPageState.galleryDetails?.torrentCount ?? '.'})',
                  style: TextStyle(fontSize: 12, color: Get.theme.appBarTheme.titleTextStyle?.color),
                ),
                onPressed: detailsPageState.galleryDetails == null ? null : detailsPageLogic.handleTapTorrent,
              ),
              IconTextButton(
                iconData: Icons.folder_zip,
                iconSize: 28,
                text: Text(
                  'archive'.tr,
                  style: TextStyle(fontSize: 12, color: Get.theme.appBarTheme.titleTextStyle?.color),
                ),
                onPressed: detailsPageState.galleryDetails == null ? null : detailsPageLogic.handleTapArchive,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTags(LinkedHashMap<String, List<TagData>> tagList) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 24),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: tagList.entries
              .map(
                (entry) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EHTag(
                      tagData: TagData(namespace: 'rows', key: entry.key),
                      withColor: true,
                    ).marginOnly(right: 10),

                    /// use [expanded] and [wrap] to implement 'flex-wrap'
                    Expanded(
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: entry.value.map((tagData) => EHTag(tagData: tagData, enableTapping: true)).toList(),
                      ),
                    ),
                  ],
                ).marginOnly(top: 10),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildLoadingDetailsIndicator() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 24),
      sliver: SliverToBoxAdapter(
        child: LoadingStateIndicator(
          indicatorRadius: 16,
          loadingState: detailsPageState.loadingDetailsState,
          errorTapCallback: detailsPageLogic.getDetails,
        ),
      ),
    );
  }

  Widget _buildCommentsIndicator(GalleryDetail galleryDetails) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Get.toNamed(Routes.comment, arguments: detailsPageState.galleryDetails!.comments),
              child: Text(
                galleryDetails.comments.isEmpty ? 'noComments'.tr : 'allComments'.tr,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildComments(GalleryDetail galleryDetails) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 135,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemExtent: 300,
          children: galleryDetails.comments
              .map(
                (comment) => GestureDetector(
                  onTap: () => Get.toNamed(Routes.comment, arguments: detailsPageState.galleryDetails!.comments),
                  child: EHComment(comment: comment, maxLines: 4),
                ).marginOnly(right: 10),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildThumbnails(GalleryDetail galleryDetails) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 36),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == galleryDetails.thumbnails.length - 1 &&
              detailsPageState.loadingThumbnailsState == LoadingState.idle) {
            /// 1. shouldn't call directly, because SliverGrid is building, if we call [setState] here will cause a exception
            /// that hints circular build.
            /// 2. when callback is called, the SliverGrid's state will call [setState], it'll rebuild all child by index, it means
            /// that this callback will be added again and again! so add a condition to check loadingState so that make sure
            /// the callback is added once.
            SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
              detailsPageLogic.loadMoreThumbnails();
            });
          }

          GalleryThumbnail thumbnail = galleryDetails.thumbnails[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => detailsPageLogic.goToReadPage(index),
                child: thumbnail.isLarge ? _buildLargeThumbnail(thumbnail) : _buildSmallThumbnail(thumbnail),
              ),
              Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.grey),
              ).paddingOnly(top: 4),
            ],
          );
        }, childCount: galleryDetails.thumbnails.length),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 220,
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 20,
          crossAxisSpacing: 5,
        ),
      ),
    );
  }

  Widget _buildLoadingThumbnailIndicator() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 8, bottom: 40),
      sliver: SliverToBoxAdapter(
        child: LoadingStateIndicator(
          errorTapCallback: () => {detailsPageLogic.loadMoreThumbnails()},
          loadingState: detailsPageState.loadingThumbnailsState,
        ),
      ),
    );
  }

  Widget _buildSmallThumbnail(GalleryThumbnail thumbnail) {
    return ConstrainedBox(
      /// 220-16-4
      constraints: const BoxConstraints(maxHeight: 200),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          /// there's a bug that after cropping, the image's length-width ratio remains(equal to the raw image),
          /// so choose to assign the size manually.
          Size imageSize = Size(thumbnail.thumbWidth!, thumbnail.thumbHeight!);
          Size size = Size(constraints.maxWidth, constraints.maxHeight);
          FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);

          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: EHImage(
              galleryImage: GalleryImage(
                  url: thumbnail.thumbUrl,
                  height: fittedSizes.destination.height,
                  width: fittedSizes.destination.width),
              completedWidgetBuilder: (ExtendedImageState state) {
                /// crop image because raw image consists of 10 thumbnails in row
                return ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  fit: BoxFit.fill,
                  sourceRect: Rect.fromLTRB(
                    thumbnail.offSet!,
                    0,
                    thumbnail.offSet! + thumbnail.thumbWidth!,
                    thumbnail.thumbHeight!,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLargeThumbnail(GalleryThumbnail thumbnail) {
    return EHImage(
      containerHeight: 200,
      galleryImage: GalleryImage(
        url: thumbnail.thumbUrl,
        height: thumbnail.thumbHeight!,
        width: thumbnail.thumbWidth!,
      ),
    );
  }
}