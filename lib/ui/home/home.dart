import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Giả sử các file này tồn tại và chứa các Widget tương ứng
import 'package:my_app/ui/discovery/discovery.dart';
import 'package:my_app/ui/home/viewmodel.dart';
import 'package:my_app/ui/now_playing/audio_player_manager.dart';
import 'package:my_app/ui/now_playing/MiniPlayer.dart';
import 'package:my_app/ui/settings/settings.dart';
import 'package:my_app/ui/user/user.dart';
import 'package:my_app/ui/now_playing/playing.dart';
import '../../data/model/song.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MusicHomePage(),
    );
  }
}

class MusicHomePage extends StatelessWidget {
  const MusicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách các widget cho từng tab
    final List<Widget> tabs = [
      const HomeTab(),
      const DiscoveryTab(), // Đảm bảo bạn đã định nghĩa các Widget này
      const AccountTab(), // Đảm bảo bạn đã định nghĩa các Widget này
      const SettingsTab(), // Đảm bảo bạn đã định nghĩa các Widget này
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        // backgroundColor: Theme.of(context).colorScheme.onInverseSurface, // Bạn có thể tùy chỉnh màu nền
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            // Sử dụng CupertinoIcons cho tính nhất quán
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note_list), // Ví dụ icon khác
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Cá nhân',
          ),

        ],
      ),
      // tabBuilder xây dựng nội dung cho tab được chọn
      tabBuilder: (BuildContext context, int index) {
        // CupertinoTabView đảm bảo rằng state của mỗi tab được giữ lại
        // khi chuyển đổi giữa các tab và cung cấp Navigator riêng cho mỗi tab.
        return CupertinoTabView(
          builder: (BuildContext context) {
            return tabs[index];
          },
        );
      },
    );
  }
}

// --- Ví dụ về các Tab Widgets (bạn cần định nghĩa chúng đầy đủ) ---

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeTabPage();
  }
}

class _HomeTabPage extends StatefulWidget {
  const _HomeTabPage({super.key});

  @override
  State<_HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<_HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
    super.initState();
  }

  void observeData() {
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  @override
  void dispose() {
    _viewModel.songStream.close();
    AudioPlayerManager().dispose();
    super.dispose();
  }

  Widget getBody() {
    bool showLoading = songs.isEmpty;
    if (showLoading) {
      return getProgressBar();
    } else {
      return CupertinoPageScaffold(
        navigationBar: cupertinoNavigationBar("Danh sách bài hát"),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: songs.isEmpty ? getProgressBar() : getListView(),
              ),
              ValueListenableBuilder<Song?>(
                valueListenable: AudioPlayerManager().currentSongNotifier,
                builder: (context, song, _) {
                  if (song != null) {
                    return MiniPlayer(song: song);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      );
    }
  }



  CupertinoNavigationBar cupertinoNavigationBar(String name) {
    return CupertinoNavigationBar(
        backgroundColor: Colors.white,
        leading: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {

              },
              child: const Icon(
                CupertinoIcons.mic,
                color: CupertinoColors.label,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => const CupertinoAlertDialog(
                    title: Text("Search"),
                    content: Text("Chức năng tìm kiếm sẽ được thêm sau."),
                    actions: [
                      CupertinoDialogAction(child: Text("OK")),
                    ],
                  ),
                );
              },
              child: const Icon(
                CupertinoIcons.search,
                color: CupertinoColors.label,
                size: 20,
              ),
            ),
          ],
        ),
      );
  }

  Widget getProgressBar() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget getListView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, position) => getRow(position),
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        thickness: 1,
        indent: 24,
        endIndent: 24,
      ),
      itemCount: songs.length,
      shrinkWrap: true,
    );
  }

  Widget getRow(int index) {
    return _SongItemSection(parent: this, song: songs[index]);
  }

  void showBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text("Options"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Add to Playlist"),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Share"),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text("Delete"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  void navigate(Song song) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return NowPlaying(songs: songs, playingSong: song);
        },
      ),
    );
  }
}

class _SongItemSection extends StatelessWidget {
  const _SongItemSection({required this.parent, required this.song});

  final _HomeTabPageState parent;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          final audioManager = AudioPlayerManager();
          audioManager.setPlaylist(parent.songs, startIndex: parent.songs.indexOf(song));

          // đợi load xong rồi mới mở
          await audioManager.player.setUrl(song.source);

          parent.navigate(song);
        },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Ảnh bo góc
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/FaviconSHOP.png',
                image: song.image,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/FaviconSHOP.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // Tên + Nghệ sĩ
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.label,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    song.artist,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Nút more (ellipsis)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => parent.showBottomSheet(),
              child: const Icon(
                CupertinoIcons.ellipsis,
                size: 22,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
