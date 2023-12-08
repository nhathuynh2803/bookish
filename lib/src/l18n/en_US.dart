import 'dart:core';

class en_US {
  static Map<String, String> keys() {
    return {
      /// common
      'yes': 'Yes',
      'no': 'No',
      'cancel': "Cancel",
      'OK': "OK",
      'reset': "Reset",
      'success': "Success",
      'error': "Error",
      'failed': "Failed",
      'reload': 'Reload',
      'noMoreData': 'No More',
      'noData': 'No Data',
      'operationFailed': 'Operation Failed',
      'needLoginToOperate': 'Need Log In To Operate',
      'hasCopiedToClipboard': "Has Copied To Clipboard",
      'networkError': "Network Error, Tap to Reload",
      'systemError': "System Error",
      'invalid': "Invalid",
      'internalError': "Internal Error",
      'you': 'You',
      'retryHint': 'Please retry after refresh',
      'stop': 'Stop',
      'attention': 'Attention',
      'jump': 'Jump',
      'deleteAll': 'Delete All',

      'home': "Home",
      'gallery': "Gallery",
      'setting': 'Setting',

      /// unlock page
      'localizedReason': 'Please authenticate to continue',
      'tap2Auth': 'Tap to Authenticate',
      'passwordErrorHint': 'Password error, please try again',

      /// start page
      'TapAgainToExit': 'Tap again to exit',

      /// update dialog
      'availableUpdate': 'Available Update!',
      'LatestVersion': 'Latest version',
      'CurrentVersion': 'Current version',
      'check': 'Check',
      'dismiss': 'Dismiss',

      /// login page
      'login': 'Login',
      'notLoggedIn': 'Login',
      'logout': 'Logout',
      'passwordLogin': 'Password Login',
      'cookieLogin': 'Cookie Login',
      'youHaveLoggedInAs': 'Hello:   ',
      'cookieIsBlack': 'Cookie is Black',
      'cookieFormatError': 'Cookie Format Error',
      'invalidCookie': 'Login failed or invalid cookie',
      'loginFail': 'Login Failed',
      'userName': 'Username',
      'EHUser': 'EH User',
      'password': 'Password',
      'needCaptcha': 'Need captcha, please login via cookie or web again.',
      'userNameOrPasswordMismatch': 'Username or password mismatch',
      'copyCookies': 'Copy Cookies',
      'tap2Copy': 'Tap to copy',
      'webLoginIsDisabled': 'Web login is disabled on desktop',
      'loginSuccess': 'Login Success',
      'userNameFormHint': 'Try with cookie in case of Sad Panda',
      'tap2Login': 'Log In',
      'parse': 'parse',

      /// request
      'sadPanda': 'Sad Panda: No Data',

      /// gallery card
      'filtered': 'Filtered',

      /// gallery page
      'getGallerysFailed': "Get Gallerys Failed",
      'refreshGalleryFailed': 'Refresh Gallery Failed',
      'tabBarSetting': 'TabBar Setting',
      'jumpPageTo': 'Jump Page To',
      'range': 'Range',
      'current': 'Current',
      'galleryUrlDetected': 'Found Gallery Url in Clipboard',
      'galleryUrlDetectedHint': 'Tap to enter detail page',

      /// details page
      'read': 'Read',
      'download': 'Download',
      'favorite': 'Favorite',
      'rating': 'Rating',
      'torrent': 'Torrent',
      'archive': 'Archive',
      'statistic': 'Statistic',
      'similar': 'Similar',
      'downloading': "Downloading",
      'resume': "Resume",
      'pause': 'Pause',
      'finished': 'Finished',
      'update': 'Update',
      'submit': 'Submit',
      'chooseFavorite': 'Choose Favorite',
      'asYourDefault': 'As Your Default',
      'uploader': 'Uploader',
      'allComments': 'All Comments',
      'noComments': 'No Comments',
      'lastEditedOn': 'Last edited on',
      'getGalleryDetailFailed': 'Get Gallery Detail Failed',
      'invisible2User': 'This Gallery is invisible to You',
      'invisibleHints': 'This gallery is removed or unavailable.',
      'copyRightHints': 'This gallery is unavailable due to a copyright claim by',
      'refreshGalleryDetailsFailed': 'Refresh Gallery Details Failed',
      'failToGetThumbnails': "Fail To Get Thumbnails",
      'favoriteGallerySuccess': "Favorite Gallery Success",
      'favoriteGalleryFailed': "Favorite Gallery Failed",
      'removeFavoriteSuccess': "Remove Favorite Success",
      'removeFavoriteFailed': "Remove Favorite Failed",
      'ratingSuccess': 'Rating Success',
      'ratingFailed': 'Rating Failed',
      'voteTagFailed': 'Vote Tag Failed',
      'beginToDownload': 'Begin To Download',
      'resumeDownload': 'Resume Download',
      'pauseDownload': 'Pause Download',
      'addNewTagSetSuccess': 'Add New Tag Set Success',
      'addNewWatchedTagSetSuccess': 'Add New Watched Tag Set Success',
      'addNewHiddenTagSetSuccess': 'Add New Hidden Tag Set Success',
      'addNewTagSetSuccessHint': 'You can check your tags at Setting->EH->My Tags',
      'addNewTagSetFailed': 'Add New Tag Set Failed',
      'VisitorStatistics': 'Visitor Statistics',
      'invisible2UserWithoutDonation': 'This gallery\'s stats is invisible to user without donation',
      'getGalleryStatisticsFailed': 'Get Gallery Statistics Failed',
      'totalVisits': 'Total Visits',
      'visits': 'Visits',
      'imageAccesses': 'Image Accesses',
      'period': 'Period',
      'ranking': 'Ranking',
      'score': 'Score',
      'NotOnTheList': 'Not on the list',
      'getGalleryArchiveFailed': 'Get Gallery Archive Failed',
      'parseGalleryArchiveFailed': 'Parse failed, make sure your [Archiver Settings] in e-hentai is [Manual Select, Manual Start (Default)]',
      'original': 'Original',
      'resample': 'Resample',
      'beginToDownloadArchive': 'Begin to Download Archive',
      'beginToDownloadArchiveHint': 'You can check progress at Download -> Archive',
      'updateGalleryError': 'Update Gallery Error',
      'thisGalleryHasANewVersion': 'This gallery has a new version',
      'hasUpdated': 'Has updated',
      'failedToDealWith': 'Failed to deal with',
      'hasDownloaded': 'Has downloaded',
      '410Hints': 'You have clocked too many downloaded bytes on this archive, and need to re-unlock of this archive to resume',
      'getUnpackedImagesFailedMsg': 'JHenTai can\'t load images of this archive, please check your local file.',
      'getGalleryTorrentsFailed': 'Get torrents failed',
      'chooseArchive': 'Choose Archive',
      'tagSetExceedLimit': 'No more tags can be added because you have reach the limit',
      'useTranslation': 'Use Translation',
      'addTagSuccess': 'Add Tag Success',
      'addTagFailed': 'Add Tag Failed',

      /// detail dialog
      'galleryUrl': 'Gallery Url',
      'title': 'Title',
      'japaneseTitle': 'Japanese Title',
      'category': 'Category',
      'publishTime': 'Publish Time',
      'pageCount': 'Page Count',
      'favoriteCount': 'Favorite Count',
      'ratingCount': 'Rating Count',

      /// comment page
      'newComment': 'New Comment',
      'updateComment': 'Update Comment',
      'commentTooShort': 'Comment is Too Short',
      'sendCommentFailed': 'Send Comment Failed',
      'voteCommentFailed': 'Vote Comment Failed',
      'voteCommentFailedHint': 'Try to pull-down to refresh details page first',
      'unknownUser': 'Unknown User',
      'atLeast3Characters': 'At least 3 characters',

      /// EHImage
      'reloadImage': "Reload Image",

      /// read page
      'parsingPage': "Parsing Page",
      'parsingURL': "Parsing URL",
      'parsePageFailed': "Parse Page Failed, Tap to Retry",
      'parseURLFailed': "Parse URL Failed, Tap to Retry",
      'loading': "Loading",
      'paused': 'Paused',
      'exceedImageLimits': "Exceed Image Limits",
      'unsupportedImagePageStyle': "JHenTai doesn't support Multi-Page Viewer(MPV), please change to default style in e-hentai.org",
      'toNext': 'To next',
      'toPrev': 'To prev',
      'back': 'Back',
      'toggleMenu': 'Toggle menu',
      'share': 'Share',
      'save': 'Save to Pictures',

      /// setting page
      'account': 'Account',
      'EH': 'EH',
      'style': 'Style',
      'preference': 'Preference',
      'network': 'Network',
      'mouseWheel': 'Mouse Wheel',
      'advanced': 'Advanced',
      'security': 'Security',
      'about': 'About',
      'accountSetting': 'Account Setting',
      'styleSetting': 'Style Setting',
      'advancedSetting': 'Advanced Setting',
      'securitySetting': 'Security Setting',
      'ehSetting': 'EH Site Setting',
      'readSetting': 'Read Setting',
      'preferenceSetting': 'Preference Setting',
      'downloadSetting': 'Download Setting',
      'networkSetting': 'Network Setting',
      'mouseWheelSetting': 'Mouse Wheel Setting',

      /// eh setting page
      'site': 'Site',
      'redirect2Eh': 'Redirect to EH if available',
      'siteSetting': 'Site Setting',
      'showCookie': 'Cookie',
      'useSeparateProfile': 'Use Separated Profile',
      'editProfileHint': 'Edit profile',
      'redirect2EH': 'Redirect to EH site if Available',
      'redirect2Hints': 'Will try to parse EH site first',
      'pleaseLogInToOperate': 'Please Log In To Operate',
      'imageLimits': 'Image Limits',
      'resetCost': 'Long press to reset, cost',
      'assets': 'Assets',

      /// tag setting page
      'myTags': 'My Tags',
      'myTagsHint': 'Manage watched and hidden tags online',
      'localTags': 'Local Tags',
      'localTagsHint': 'Extra filter tags',
      'localTagsHint2': 'Gallerys with these tags will be hidden',
      'addLocalTags': 'Add Tags',
      'hidden': 'Hidden',
      'nope': 'Nope',
      'getTagSetFailed': 'Get Tag Set Failed',
      'updateTagSetFailed': 'Update Tag Set Failed',
      'deleteTagSetSuccess': 'Delete Tag Set Success',
      'deleteTagSetFailed': 'Delete Tag Set Failed',
      'addLocalTagHint': 'Search to add new tag',

      /// add host mapping dialog
      'addHostMapping': 'Add Host Mapping',

      /// Layout
      'layoutMode': 'Layout Mode',
      'mobileLayoutV2Name': 'Mobile',
      'mobileLayoutV2Desc': 'Single column',
      'mobileLayoutName': 'Mobile(old)',
      'mobileLayoutDesc': 'Maintenance stopped',
      'tabletLayoutV2Name': 'Tablet',
      'tabletLayoutV2Desc': 'Double column',
      'tabletLayoutName': 'Tablet(old)',
      'tabletLayoutDesc': 'Maintenance stopped',
      'desktopLayoutName': 'Desktop',
      'desktopLayoutDesc': 'Double column with left tab bar, supports keyboard',

      /// style setting page
      'enableTagZHTranslation': 'Translate Tag Name into Chinese',
      'version': 'Version',
      'downloadTagTranslationHint': 'Downloading data..., downloaded: ',
      'themeMode': 'Theme Mode',
      'dark': 'Dark',
      'light': 'Light',
      'followSystem': 'Follow System',
      'themeColor': 'Theme Color',
      'listStyle': 'Gallery List Style (Global)',
      'flat': 'Flat',
      'flatWithoutTags': 'Flat(Without Tags)',
      'listWithoutTags': 'Card(Without Tags)',
      'listWithTags': 'Card',
      'waterfallFlowSmall': 'Waterfall Flow (Small)',
      'waterfallFlowMedium': 'Waterfall Flow (Medium)',
      'waterfallFlowBig': 'Waterfall Flow (Big)',
      'crossAxisCountInWaterFallFlow': 'Waterfall Flow Column Count',
      'pageListStyle': 'Gallery List Style (Page)',
      'crossAxisCountInGridDownloadPageForGroup': 'Download Page Grid Column Count(Group)',
      'crossAxisCountInGridDownloadPageForGallery': 'Download Page Grid Column Count(Gallery)',
      'global': 'Global',
      'auto': 'Auto',
      'moveCover2RightSide': 'Move Cover to Right Side',
      'coverStyle': 'Cover Style',
      'cover': 'Cover',
      'adaptive': 'Adaptive',
      'simpleDashboardMode': 'Simple Home Page',
      'simpleDashboardModeHint': 'Hide Ranklist and Popular',
      'hideBottomBar': 'Hide Bottom Bar',
      'hideScroll2TopButton': 'Hide Scroll to Top Button',
      'whenScrollUp': 'When Scroll Up',
      'whenScrollDown': 'When Scroll Down',
      'enableSwipeBackGesture': 'Enable Swipe Back Gesture',
      'enableLeftMenuDrawerGesture': 'Enable Left Menu Drawer Gesture',
      'enableQuickSearchDrawerGesture': 'Enable QuickSearch Drawer Gesture',
      'drawerGestureEdgeWidth': 'Drawer Gesture Edge Width',
      'alwaysShowScroll2TopButton': 'Always Show Scroll to Top Button',
      'enableDefaultFavorite': 'Enable Default Favorite',
      'enableDefaultFavoriteHint': 'Long press to re-select',
      'launchInFullScreen': 'Launch In Full Screen',
      'launchInFullScreenHint': 'Switch manually by F11',
      'disableDefaultFavoriteHint': 'Select manually',
      'tagSearchBehaviour': 'Tag Search Behaviour',
      'inheritAll': 'Inherit All',
      'inheritAllHint': 'Use last search options for tag search',
      'inheritPartially': 'Inherit Partially',
      'inheritPartiallyHint': 'Use last search options for tag search(except language and category)',
      'none': 'None',
      'noneHint': 'Use default search options for tag search',
      'showComments': 'Show Comments',
      'showAllComments': 'Show All Comments',
      'showAllCommentsHint': 'By default only the 45 highest scoring and 5 most recent comments will be shown',
      'addTag': 'Add Tag',
      'addTagHint': 'Enter new tags, separated with comma',

      /// theme color setting page
      'themeColorSettingHint': 'Assign different color for light and dark theme',
      'preview': 'Preview',
      'preset': 'Preset',
      'custom': 'Custom',

      /// mouse wheel setting page
      'wheelScrollSpeed': 'Wheel scroll speed',
      'ineffectiveInGalleryPage': 'Ineffective in gallery page now.',

      /// advanced setting page
      'enableDomainFronting': 'Enable Domain Fronting',
      'bypassSNIBlocking': 'Bypass SNI blocking',
      'hostMapping': 'Host Mapping',
      'hostMappingHint': 'Used for domain fronting',
      'proxyAddress': 'Proxy Address',
      'proxyAddressHint': 'If you use proxy server, make sure to set it up correctly',
      'saveSuccess': 'Save success',
      'updateSuccess': 'Update success',
      'connectTimeout': 'Connect Timeout',
      'receiveTimeout': 'Receive Data Timeout',
      'pageCacheMaxAge': 'Page Cache Max Age',
      'pageCacheMaxAgeHint': 'You can update cache by refresh page',
      'oneMinute': '1 Minute',
      'tenMinute': '10 Minute',
      'oneHour': '1 Hour',
      'oneDay': '1 Day',
      'threeDay': '3 Day',
      'enableLogging': 'Enable Logging',
      'enableVerboseLogging': 'Enable Verbose Logging',
      'openLog': 'Open Log',
      'clearLogs': 'Clear Logs',
      'clearImagesCache': 'Clear Images Cache',
      'longPress2Clear': 'Long press to clear',
      'checkUpdateAfterLaunchingApp': 'Check update after launching app',
      'checkClipboard': 'Check Gallery URL in Clipboard',
      'clearPageCache': 'Clear Page Cache',
      'clearSuccess': 'Clear Success',
      'superResolution': 'Image Super Resolution',
      'stopSuperResolution': 'Stop Super Resolution',
      'deleteSuperResolvedImage': 'Delete Super Resolved Image',
      'superResolveOriginalImageHint': 'Process original image cost more time, space and performance, are you sure to continue?',
      'verityAppLinks4Android12': 'Verity App Links(Android 12+)',
      'verityAppLinks4Android12Hint': 'For Android 12+, you need to manually add link to verified links in order to open JHenTai in 3-rd apps',
      'noImageMode': 'No Image Mode',

      /// host mapping page
      'hostDataSource': 'No need to change by default.\nData source: https://dns.google/',

      /// proxy page
      'proxySetting': 'Proxy Setting',
      'proxyType': 'Proxy Type',
      'systemProxy': 'System',
      'httpProxy': 'HTTP',
      'socks5Proxy': 'SOCKS5',
      'socks4Proxy': 'SOCKS4',
      'directProxy': 'DIRECT',
      'address': 'Address',

      /// security setting page
      'enablePasswordAuth': 'Enable Password Auth',
      'enableBiometricAuth': 'Enable Biometric Auth',
      'enableAuthOnResume': 'Enable Auth on Resume',
      'enableAuthOnResumeHints': '3 seconds delay',
      'enableBlurBackgroundApp': 'Enable Blur Page When Switch to Background',
      'hideImagesInAlbum': 'Hide Images in Album',
      'hideImagesInAlbumHints': 'If you changed default download path, you need to create .nomedia manually',

      /// read setting page
      'enableImmersiveMode': 'Enable Immersive Mode',
      'keepScreenAwakeWhenReading': 'Keep Screen Awake When Reading',
      'spaceBetweenImages': 'Space Between Images',
      'enableImmersiveHint': 'Hide System Bar',
      'enableImmersiveHint4Windows': 'Hide Title Bar',
      'deviceOrientation': 'Device Orientation',
      'landscape': 'Landscape',
      'portrait': 'Portrait',
      'readDirection': 'Read Direction',
      'useThirdPartyViewer': 'Use Custom Viewer',
      'thirdPartyViewerPath': 'Custom Viewer Path(Executable file)',
      'showThumbnails': 'Show Thumbnails',
      'showStatusInfo': 'Show Status at Bottom',
      'autoModeInterval': 'Turn Page Interval',
      'autoModeStyle': 'Auto mode style',
      'scroll': 'Scroll',
      'turnPage': 'Turn page',
      'top2bottomList': 'Top to Bottom (Continuous)',
      'left2rightSinglePage': 'Left to Right (Single Page)',
      'left2rightSinglePageFitWidth': 'Left to Right (Fit Width)',
      'right2leftSinglePage': 'Right to Left (Single Page)',
      'right2leftSinglePageFitWidth': 'Right to Left (Fit Width)',
      'left2rightDoubleColumn': 'Left to Right (Double Column)',
      'right2leftDoubleColumn': 'Right to Left (Double Column)',
      'left2rightList': 'Left to Right (Continuous)',
      'right2leftList': 'Right to Left (Continuous)',
      'enablePageTurnByVolumeKeys': 'Use volume key to turn page',
      'enablePageTurnAnime': 'Enable Turn Page Animation',
      'enableDoubleTapToScaleUp': 'Enable Double Tap to Scale up',
      'enableTapDragToScaleUp': 'Enable Tap Drag to Scale up',
      'enableBottomMenu': 'Enable Bottom Menu',
      'reverseTurnPageDirection': 'Reverse Page Turning Direction',
      'disableGestureWhenScrolling': 'Disable Gesture When Scrolling',
      'turnPageMode': 'Turn Page Mode',
      'turnPageModeHint': 'To next screen or next image',
      'image': 'Image',
      'screen': 'Screen',
      'preloadDistanceInOnlineMode': 'Preload Distance(Online)',
      'ScreenHeight': 'Screen',
      'preloadPageCount': 'Preload Page Count',
      'continuousScroll': 'Continuous Scroll',
      'continuousScrollHint': 'Splice multiple images',
      'doubleColumn': 'Double Column',
      'displayFirstPageAlone': 'Display First Page Alone',
      'displayFirstPageAloneGlobally': 'Display First Page Alone(Globally)',
      'toggleFullScreen': 'Toggle Full Screen',
      'enableAutoScaleUp': 'Enable Auto Scale up Long Image',
      'enableAutoScaleUpHints': 'Make image width same as screen width',

      /// preference setting page
      'showR18GImageDirectly': 'Show R18G Image Directly',
      'defaultTab': 'Default Tab',

      /// log page
      'logList': 'Log List',

      /// super resolution setting page
      'downloadSuperResolutionModelHint': 'Download Model From Github',
      'modelDirectoryPath': 'Model Directory Path',
      'upSamplingScale': 'Up Sampling Scale',
      'modelType': 'Choose Model',
      'x4plusHint': 'Take up more space but faster at most time',
      'x4plusAnimeHint': 'Take up less space but slower at most time',
      'enable4OnlineReading': 'Process Automatically While Reading Online',

      /// download page
      'local': 'Local',
      'reDownload': 'Re-Download',
      'delete': 'Delete',
      'deleteTask': 'Delete Task Only',
      'deleteTaskAndImages': 'Delete Task And Images',
      'unlocking': 'unlocking',
      'parsingDownloadPageUrl': 'Parsing download page url',
      'parsingDownloadUrl': 'Parsing download url',
      'downloaded': 'Downloaded',
      'downloadFailed': 'DownloadFailed',
      'unpacking': 'Unpacking',
      'completed': 'Completed',
      'needReUnlock': 'Need Re-Unlock',
      'reUnlock': 'Re-Unlock',
      'reUnlockHint': 'Attention! Re-unlock need to buy this archive again.',
      'downloadHelpInfo': 'If you can\'t download and find errors like table doesn\'t exist in logs, please uninstall current app and re-install.',
      'localGalleryHelpInfo':
          'Load gallerys which is not downloaded by JHenTai. Add config in Download Setting -> Extra Gallery Scan Path and then refresh.',
      'localGalleryHelpInfo4iOSAndMacOS':
          'Load gallerys which is not downloaded by JHenTai. Put your gallerys in default download path and then refresh',
      'deleteLocalGalleryHint': 'Delete your local files',
      'priority': 'Priority',
      'highest': 'Highest',
      'default': 'Default',
      'newGalleryCount': 'New gallery count',
      'changePriority': 'Change Priority',
      'changeGroup': 'Change Group',
      'chooseGroup': 'Choose Group',
      'renameGroup': 'Rename Group',
      'deleteGroup': 'Delete Group',
      'groupName': 'Group Name',
      'drag2sort': 'Drag to Sort',
      'switch2GridMode': 'Switch to Grid Mode',
      'switch2ListMode': 'Switch to List Mode',
      'multiSelect': 'Multi-Select',
      'multiSelectHint': 'Tap to select',
      'resumeAllTasks': 'Resume All Tasks',
      'pauseAllTasks': 'Pause All Tasks',
      'requireDownloadComplete': 'Require download complete',
      'operationHasCompleted': 'The operation has completed',
      'operationInProgress': 'The operation is in progress',
      'startProcess': 'Start Process',
      'multiReDownloadHint': 'You will re-download all selected gallerys',
      'multiChangeGroupHint': 'You will change group of all selected gallerys',
      'multiDeleteHint': 'You will delete all selected gallerys',

      /// search dialog
      'searchConfig': 'Search Config',
      'addTabBar': 'Add Tab Bar',
      'updateTabBar': 'Update Tab Bar',
      'addQuickSearch': 'Add',
      'updateQuickSearch': 'Update',
      'filter': 'Filter',
      'tabBarName': 'TabBar Name',
      'quickSearchName': 'Name',
      'pleaseInputValidName': 'Please input valid name',
      'sameNameExists': 'Same name exists',
      'searchType': 'Search Type',
      'popular': 'Popular',
      'ranklist': 'Ranklist',
      'ranklistBoard': 'Ranklist',
      'watched': 'Watched',
      'history': 'History',
      'keyword': 'Keyword',
      'orderBy': 'Order by',
      'favoritedTime': 'Favorited Time',
      'publishedTime': 'Published Time',
      'backspace2DeleteTag': 'Backspace to Delete Tag',
      'searchGalleryName': 'Search Gallery Name',
      'searchGalleryTags': 'Search Gallery Tags',
      'searchGalleryDescription': 'Search Gallery Description',
      'onlySearchExpungedGalleries': "Only Search Expunged Galleries",
      'onlyShowGalleriesWithTorrents': 'Only Show Galleries With Torrents',
      'searchLowPowerTags': 'Search LowPower Tags',
      'searchDownVotedTags': 'Search DownVoted Tags',
      'pageAtLeast': 'Page At Least',
      'pageAtMost': 'Page At Most',
      'pagesBetween': 'Pages Between',
      'pageRangeSelectHint': 'min <= 1000, max >= 10\nmin/max <= 0.8, max-min >= 20',
      'to': 'to',
      'minimumRating': 'Minimum Rating',
      'disableFilterForLanguage': 'Disable Filter For Language',
      'disableFilterForUploader': 'Disable Filter For Uploader',
      'disableFilterForTags': 'Disable Filter For Tags',
      'searchName': 'Search Name',
      'searchTags': 'Search Tags',
      'searchNote': 'Search Note',
      'allTime': 'All',
      'year': 'Year',
      'month': 'Mon',
      'day': 'Day',

      /// popular page
      'getPopularListFailed': 'Get Popular List Failed',

      /// ranklist page
      'getRanklistFailed': 'Get Ranklist Failed',
      'getSomeOfGallerysFailed': 'Get Some of Gallerys Failed',

      /// history page
      'getHistoryGallerysFailed': 'Get Some of History Gallerys Failed',

      /// search page
      'search': 'Search',
      'searchFailed': 'Search Failed',
      'fileSearchFailed': 'File Search Failed',
      'tab': 'Tab',
      'openGallery': 'Open Gallery',
      'tapChip2Delete': 'Tap chip to delete',

      /// about page
      'author': 'Author',
      'Q&A': 'Q&A',
      'telegramHint': 'You can ask your questions in github first',

      /// download setting page
      'downloadPath': 'Download Path',
      'changeDownloadPathHint':
          'Long press to change(do not use SD-Card or any system path). Will copy downloaded gallerys automatically and keep old files. If you meet any error, try to reset.',
      'resetDownloadPath': 'Reset Download Path',
      'extraGalleryScanPath': 'Extra Gallery Scan Path',
      'extraGalleryScanPathHint': 'To scan and load local gallerys',
      'singleImageSavePath': 'Single Image Save Path',
      'downloadOriginalImage': 'Original Image',
      'downloadOriginalImageByDefault': 'Choose Original Image By Default',
      'originalImage': 'Original',
      'resampleImage': 'Resample',
      'never': 'Never',
      'manual': 'Manual',
      'always': 'Always',
      'longPress2Reset': 'Long Press to Reset',
      'needPermissionToChangeDownloadPath': 'Need permission to change download path',
      'invalidPath': 'Invalid Path. Avoid using SD-Card, system path or root path.',
      'downloadTaskConcurrency': 'Download Concurrency',
      'needRestart': 'Need restart',
      'speedLimit': 'Speed Limit',
      'speedLimitHint': 'Don\'t download too fast',
      'per': 'per',
      'images': 'images',
      'downloadTimeout': 'Download Timeout',
      'downloadAllGallerysOfSamePriority': 'Download All Gallerys of Same Priority',
      'downloadAllGallerysOfSamePriorityHint': 'Download only 1 gallery simultaneously in 1 group with highest priority by default',
      'alwaysUseDefaultGroup': 'Always Use Default Group',
      'enableStoreMetadataForRestore': 'Enable Store Metadata for Restore',
      'enableStoreMetadataForRestoreHint': 'If disable this, you can\'t restore download tasks',
      'deleteArchiveFileAfterDownload': 'Delete Archive .zip File After Download',
      'restoreDownloadTasks': 'Restore Download Tasks',
      'restoreDownloadTasksHint': 'Restore download tasks by metadata',
      'restoreDownloadTasksSuccess': 'Restore Download Tasks Success',
      'restoredCount': 'Restored task count',
      'restoredGalleryCount': 'Restored gallery count',
      'restoredArchiveCount': 'Restored archive count',
      'brokenDownloadPathHint': 'Seems your download path is broken, download function may be ineffective',
      'brokenExtraScanPathHint': 'Seems your default local gallery path is broken, local gallery may be not recognized',

      /// password setting dialog
      'setPasswordHint': 'Please input your password',
      'confirmPasswordHint': 'Please input your password again',
      'passwordNotMatchHint': 'Password not match, try again',

      /// quick search page
      'quickSearch': 'Quick Search',

      /// dashboard page
      'seeAll': 'All',
      'newest': 'Latest',

      /// tag dialog
      'warningImageHint': 'R18G image, Tap to view',

      /// tag namespace
      'language': 'Language',
      'artist': 'Artist',
      'character': 'Character',
      'female': 'Female',
      'male': 'Male',
      'parody': 'Parody',
      'group': 'Group',
      'mixed': 'Mixed',
      'Coser': 'Coser',
      'cosplayer': 'Cosplayer',
      'reclass': 'Reclass',
      'temp': 'Temp',
      'other': 'Other',
    };
  }
}
