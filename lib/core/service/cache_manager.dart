// import 'package:flutter_cache_manager/file.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// class CacheManagerAudio {
//   static const _key = 'customCacheKeyAudio';

//   final _cacheManager = CacheManager(
//     Config(
//       _key,
//       stalePeriod: const Duration(days: 365),
//       maxNrOfCacheObjects: 1000,
//       repo: JsonCacheInfoRepository(databaseName: _key),
//       fileService: HttpFileService(),
//     ),
//   );

//   Future<File?> getFileCache(String url) async {
//     try {
//       return await _cacheManager.getSingleFile(url);
//     } catch (e) {
//       return null;
//     }
    
//   }
// }
