import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/data/model/song.dart';

class FavoriteSongsPage extends StatelessWidget {
  final List<Song> favoriteSongs;

  const FavoriteSongsPage({super.key, required this.favoriteSongs});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Danh sách yêu thích ❤️"),
      ),
      child: SafeArea(
        child: favoriteSongs.isEmpty
            ? const Center(child: Text("Chưa có bài hát yêu thích"))
            : Material( // ✅ Thêm Material để ListTile không báo lỗi
          child: ListView.builder(
            itemCount: favoriteSongs.length,
            itemBuilder: (context, index) {
              final song = favoriteSongs[index];
              return ListTile(
                leading: Image.network(
                  song.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(song.title),
                subtitle: Text(song.artist),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: Text(song.title),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Thêm xử lý "Phát nhạc"
                            },
                            child: const Text("Phát"),
                          ),
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Xóa khỏi yêu thích"),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Hủy"),
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.ellipsis,
                    size: 22,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
