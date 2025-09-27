import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/data/model/song.dart';
import 'package:my_app/ui/settings/ListFavorite.dart';

class SettingsTab extends StatefulWidget {
  final List<Song> favoriteSongs;

  const SettingsTab({super.key, required this.favoriteSongs});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            'Cá nhân',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.black,
            ),
          ),
        ),
        // Bên phải: 3 icon
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.settings_solid),
              onPressed: () {
                // Xử lý Cài đặt
              },
            ),
            const SizedBox(width: 12),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.bell),
              onPressed: () {
                // Xử lý Thông báo
              },
            ),
            const SizedBox(width: 12),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.search),
              onPressed: () {
                // Xử lý Tìm kiếm
              },
            ),
          ],
        ),
        border: null, // loại bỏ viền dưới nếu muốn
        backgroundColor: CupertinoColors.systemGrey6,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phần header: hình ảnh + tên
              Row(
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40), // hình tròn
                    // child: Image.network(
                    //   'https://i.pravatar.cc/150?img=3', 
                    //   width: 60,
                    //   height: 60,
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.asset('assets/FaviconSHOP.png',width: 60,height: 60,fit: BoxFit.cover,),
                  ),
                  
                  const SizedBox(width: 16),
                  // Tên người dùng
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Lê Hồng Quốc', // tên người dùng
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        'Chào mừng bạn!', // có thể thêm lời chào
                        style: TextStyle(fontSize: 14, color: Colors.grey,decoration: TextDecoration.none,),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Container Yêu thích
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => FavoriteSongsPage(
                            favoriteSongs: widget.favoriteSongs,
                          ),
                        ),
                      ).then((_) {
                        setState(() {}); // refresh count sau khi quay về
                      });
                    },
                    child: _buildItem(
                      icon: Icons.favorite,
                      color: Colors.red,
                      title: 'Yêu thích',
                      count: widget.favoriteSongs.length.toString(),
                    ),
                  ),

                  // Container Tải xuống
                  _buildItem(
                    icon: Icons.download,
                    color: Colors.blue,
                    title: 'Tải xuống',
                    count: '5',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Hàm tái sử dụng để tạo container
  Widget _buildItem({
    required IconData icon,
    required Color color,
    required String title,
    required String count,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      width: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon trong vòng tròn
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            count,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
